---
title: Integrating Simulators to SimBricks
subtitle: |
  Practical tips and guides to connect multiple simulators using SimBricks
date: 2024-08-21
author: hejing
permalink: /blog/integrating-simulators.html
card_image: /assets/images/blog/integrating-simulators-card.png
---
SimBricks enables the modular integration of multiple simulators to create full
system simulations. As discussed in our [previous
post](https://www.simbricks.io/blog/technical-overview.html), this is
accomplished by defining standardized interfaces to which simulators can be
connected. To integrate a simulator with SimBricks, users simply need to
implement an adapter that interacts with these predefined interfaces. In this
blog post, we will focus on the practical aspects of implementing these
adapters. We’ll delve into essential concepts and provide step-by-step guides to
help you effectively connect your simulators using SimBricks.


# Understanding the Interface and the Message Types
SimBricks interfaces are designed based on the natural boundaries of components,
with simulators connected through message exchanges via these interfaces. For
instance, a PCIe interface links a host to a hardware device, while an Ethernet
interface connects a NIC simulator to a network simulator.

The first step in integrating simulators is to understand the specific interface
and message types involved. For example, the SimBricks PCIe interface models at
the transaction layer, where message types between the device and the host
include INIT_DEV, DMA_READ/WRITE, MMIO_COMPLETE, and INTERRUPT. Below is an
example of the DMA_READ message type defined in SimBricks. The full list of
message types available in [this
file](https://github.com/simbricks/simbricks/blob/main/lib/simbricks/pcie/proto.h).
Besides standard transaction layer fields like request ID, messages also include
a timestamp indicating when they should be processed.

As we will tell more detail, the adapter interprets these messages and
translates them into actions within the simulator. This process works in reverse
for events coming from the simulator to the interface.

```c
struct SimbricksProtoPcieD2HRead {
  uint64_t req_id;
  uint64_t offset;
  uint16_t len;
  uint8_t pad[30];
  uint64_t timestamp;
  uint8_t pad_[7];
  uint8_t own_type;
} __attribute__((packed));
SIMBRICKS_PROTO_MSG_SZCHECK(struct SimbricksProtoPcieD2HRead);
```

# Implementing the Adapter
Once we figured out the interface and the message type to be used, we can begin
writing an adapter.  For illustration, we’ll use an
[example](https://gitlab.cs.uni-saarland.de/os/hwaccel-23ws/project/-/blob/main/ms2/accel-sim/plumbing.c?ref_type=heads)
where we integrated a matrix multiplication accelerator as a PCIe device. 
At a
high level, implementing an adapter involves three key components: 
1. Adapter initialization
2. Handingling incoming messages
3. Implementing the main loop of simulation

## Adapter initialization
This part involves initializing the shared memory queues and establishing
connections with the peer simulators. In the case of a PCIe device simulator, it
will send the device information message to the host during this process. The
necessary helper functions for initialization are already implemented in the
SimBricks library for ease of use.

## Handling the incoming messages
The main simulation loop continuously polls each queue between it and all the
peers. Once a message is ready for processing, the adapter interprets the
message from the SimBricks channel and calls the corresponding internal
simulator functions to inject the event into the simulator. This function needs
to be implemented with a switch case to handle each message type. Below is an
example from our Matrix Multiplication accelerator for handling an MMIO_READ
message received from the PCIe channel.

```c
static void PollPcie(void) {
  volatile union SimbricksProtoPcieH2D *msg =
      SimbricksPcieIfH2DInPoll(&pcie_if, main_time);
  uint8_t type;

  if (msg == NULL)
    return;

  type = SimbricksPcieIfH2DInType(&pcie_if, msg);
  switch (type) {
    case SIMBRICKS_PROTO_PCIE_H2D_MSG_READ:
      MMIORead(&msg->read);
      break;

    case OTHER_TYPES_OF_MESSAGES:{
      // Handle other types of messages
    }

```

## Implementing the Main Loop of Simulation
The other part to implement is the main simulation loop. The main loop needs to
repeatedly poll all the message queues and update its local time according to
the timestamps of the received messages. It is also where the [synchronization
mechanism](https://www.simbricks.io/blog/accurate-efficient-scalable-synchronization.html)
is implemented. For reference on the main loop implementation, see the the
RunLoop function in the [Matrix multiplication accelerator
example](https://gitlab.cs.uni-saarland.de/os/hwaccel-23ws/project/-/blob/main/ms2/accel-sim/plumbing.c?ref_type=heads).

# Adding the Simulator to the Orchestration Framework
Lastly, we need to add the simulator to our orchestration framework. Create a
simulator class that inherits from the PCI device simulator class and configure
the command to run the simulator. With this simulator class defined in the
orchestration framework, we can invoke it in the [experiment
script](https://gitlab.cs.uni-saarland.de/os/hwaccel-23ws/project/-/blob/main/ms2/tests/test0.sim.py?ref_type=heads)
and run it alongside other components in an end-to-end environment. For further
guidance to the simulation script, refer to our [previous blog
post](https://www.simbricks.io/blog/orchestration_framework.html) on running a
simple experiment with the orchestration framework.

```python
# Simulator component for our accelerator model
class HWAccelSim(sim.PCIDevSim):
    sync = True

    def __init__(self, op_latency, matrix_size):
        super().__init__()
        self.op_latency = op_latency
        self.matrix_size = matrix_size

    def run_cmd(self, env):
        cmd = '%s%s %d %d %s %s' % \
            (os.getcwd(), '/accel-sim/sim', self.op_latency, self.matrix_size,
             env.dev_pci_path(self), env.dev_shm_path(self))
        return cmd
```
This post reviewed the important steps for integrating a new simulator to
SimBricks and run it in an end-to-end environment. If you have any questions,
welcome to:


---
layout: use-cases
header_color: green
title: "Use-Cases"
subtitle: "Examples how to use SimBricks in your workflow"
permalink: /use-cases.html
---

# 1 Developing Applications and Hardware-Software Interfaces
{: .titlebar }
- functional simulation with interactive simulation speed
- performance is inaccurate but functionality-wise, behavior is the same as in
  physical system
- serves as playground to write workload software and hardware drivers, that
  interact with the underlying hardware 
- applicable to any stage of hardware development
- pre-silicon / pre-rtl: software engineers can already write the software to
  interface with hardware
- running full-blown Linux with unmodified applications, so the written software
  will work as-is in later physical system


# 2 Early Design Exploration with Performance Behavioral Models
{: .titlebar }
- many system- and component-level design choices like network topology,
  architectural parameters of custom hardware, the hardware-software interface
  to use
- all these design choices pose trade-offs between performance and cost
  (up-front manufacturing costs, operational costs like energy consumption)
- trade-offs depend on the concrete workload and applications and how
  effectively they can make use of the underlying system/hardware
- SimBricks uses clearly defined interfaces to connect components
- Doesn't care about what plugs into the two ends 
- Can plug anything into the other end as long as it behaves as the component on
  the other side expects
- This can be used in pre-rtl exploration by writing behavioral models in C++
  that estimate the performance of a custom hardware component with a concrete
  set of design parameters
- Can use this to explore performance implications of early design choices onto
  the whole system/workload and make well-founded decisions


# 3 Incremental RTL Development (BM + Verilog)
{: .titlebar }
- while developing a system using custom hardware, the RTL for some code is
  available while for others it is still work in progress
- yet, when testing the individual components we want to supply representative
  inputs, i.e. inputs that are going to be applied in the finished system
- we therefore write per-component Verilog testbenches that try to emulate the
  workload's behavior
- with SimBricks, can evaluate against the actual workload inputs early on
- the condition is that for components, where the RTL is still under
  development, we have behavioral models available
- this is typically the case since we used these during design exploration
- build a virtual testbed by connecting RTL and BM components through their
  natural interfaces (AXI, PCIe, Ethernet)
- connect a linux host running the workload application
- this will accurately apply the inputs at the RTL components up to the
  inaccuracies in the host's model and the behavioral models 


# 4 (Large-Scale) Full-System Performance Evaluation
{: .titlebar }
- testing in physical testbed is currently implausible, either because we don't
  have access to the necessary hardware or because we can't realize the concrete
  configuration
- for example, we are developing custom hardware and are still pre-silicon, we
  otherwise don't have access to the required hardware or we can't make the
  required configuration changes for testing since we are dealing with a
  production system
- We have access to the RTL code and accurate simulators for the individual
  components though
- With SimBricks, we can do a component-wise translation from the physical
  system into a virtual testbed and run the unmodified software and workloads
- This allows us to conduct fully end-to-end performance evaluation and answer
  questions like how long is the latency observed by the user to request
  completion? How many users can my system handle?

- SimBricks' synchronization mechanism can scale to 1000s of hosts with only
  small penalties to simulation speed
- This will require a lot of processing resources though since every component
  simulator requires its own thread
- As a solution, we also support mixed-fidelity simulations where, for example,
  you can model background traffic hosts with lower fidelity in the network and
  only conduct the hosts directly involved into the performance measurements
  high fidelity
- this way, 

# 5 Instruction and Teaching
{: .titlebar }

- deep visibility into the system
- same interfaces between components like in a corresponding physical system
- teach students about hardware-software interfaces
- playground
- can produce a graph of simulation topology to explain connections in system

# Additional Notes
- Mention SystemC for simulating IP under use-case 3?
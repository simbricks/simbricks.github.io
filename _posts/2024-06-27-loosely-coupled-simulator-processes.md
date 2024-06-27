---
title: "Loosely Coupled Simulator Processes for Parallelism and Easy Integration"
subtitle: "Our secret to scalably connect and integrate a range of independent
and often incompatible simulators into a coherent whole."
date: 2024-06-27
author: jonas
permalink: /blog/loosely-coupled-simulator-processes.html
card_image: /assets/images/blog/loosely-coupled-simulator-processes.png
---

SimBricks assembles full-system simulation from multiple simulators running as
separate, loosely coupled processes. We connect individual simulators by
introducing adapters, which take simulators' internal APIs and translate them to
SimBricks boundary protocols. These are based on real system component
boundaries, such as PCIe and Ethernet. Simulator internals remain untouched by
running each simulator as a separate process. By just adding an adapter, we can
easily integrate additional simulators and connect them to already integrated
simulators. Adapters connect simulators pairwise and communicate through message
passing. We also implement simulator clock synchronization as part of the
adaptors and on top of message passing (more on that in a future post).

![Figure with three component simulators a in separate labeled as processes.
Each simulator has one or multiple adapters connecting it to other simulator
processes.](/assets/images/blog/loosely-coupled-simulator-processes.svg)

# Connecting Simulators through Adapters

SimBricks connects simulators for a wide range of individual components written
in different programming languages, which possibly also operate incompatible
simulation modes like discrete event simulations, cycle-by-cycle circuit
simulations, and simulations using mathematical models. For easy integration, we
do not modify the simulator's internal structures and run them in separate
processes while establishing communication through shared-memory message
passing.

We build on the simulators' existing simulator-specific APIs for extensions and
adapt them to our common SimBricks interface to enable modular composition. This
enables users to easily swap out the simulator on the other side of a
connection. We also avoid simulators having to be aware of any implementation
details or simulator-specific APIs of their connected peer simulators. We
compose simulators at natural boundaries reflecting those in real systems, e.g.
PCIe or Ethernet. These typically also align with the division of
responsibilities between existing component simulators. We add adapter
components as extensions to component simulators for each applicable boundary
protocol.


# Simulator-Native Adapters Enable Easy Integration

A SimBricks adapter is a native part of its respective simulator and executes in
the same process. It is typically written in the same programming language and
uses the simulator's internal APIs and configuration mechanisms. For
communication with peer simulators, the adapter builds on our core SimBricks
library implementing our communication primitives. Adapters are lightweight
extensions and do not require deeper modifications to component simulators.
Integrating additional simulators is therefore straightforward and mostly
revolves around connecting the pieces. 

An adapter receives boundary-specific messages from peer simulators and reacts
by invoking simulator-internal functions and sending response messages back. On
the inside, the adapter reacts to simulator-internal events and sends out
messages for things the peer has to handle.

Let's make this more concrete by looking at how we implemented a PCIe adapter
for the gem5 host simulator, which allows us to connect PCIe devices simulated
by other simulators to a complete machine capable of booting Linux. Our
SimBricks adapter inherits from gem5's C++ base class for PCIe devices. As part
of this, it has to implement certain callback functions, e.g. to handle
read requests the CPU sends to the device. Instead of responding directly, the
adapter forwards the request as a SimBricks message to the device simulator. In
turn, the adapter receives messages from the device like a DMA (direct memory
access) request. The adapter handles these by invoking the respective
gem5-internal functions and responding with another message if necessary. 

# Parallelizing Simulator Processes for Scalable Simulations

A simulator can have many adapters, however, an instance of an adapter is always
connected to exactly one other peer adapter instance. This allows users to
assemble arbitrary configurations instantiating the same simulator as separate
processes as the structure of the simulated system dictates.

Not modifying simulator internals also implies that each simulator still runs
its own internal clock. However, meaningful performance results do require exact
timing across components. To this end, our synchronization protocol works along
the adapter-to-adapter connections and tags messages with precise arrival times
for clock synchronization. Component instances are thus loosely coupled and can
be simulated in parallel. Increasing the size of the simulated system by
including more components requires additional computational resources for the
additional processes, but overall simulation time will remain the same or only
increase minimally.

Stay tuned for upcoming blog posts that shed more light on the message-passing
communication between adapters and our efficient and accurate synchronization
technique. Until then:

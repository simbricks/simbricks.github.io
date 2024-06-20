---
title: "Modular Full System Simulation"
subtitle: |
  How does SimBricks work? What technical pieces are required to
  assemble full system simulations from component simulators?
date: 2024-06-20
author: antoine
permalink: /blog/technical-overview.html
card_image: /assets/images/blog/technical-overview.jpg
---

SimBricks enables users to simulate complex hardware-software systems comprising
potentially many different components. To this end, SimBricks combines and
connects different best-of-breed simulators into a modular simulation that
reflects the structure of the simulated system. Integrating a broad range of
different and potentially incompatible simulators, keeping simulation times low
even for large-scale systems, generating meaningful performance results, and
making it easy for users to configure and run complex simulations, are
significant challenges. This post provides a first overview of our core
technical pieces and how they fit together, while future posts will dig into
individual components in much more detail.

![Overview of the core technical pieces in SimBricks.](/assets/images/blog/technical-overview.jpg)


# Natural Component Interfaces for Modularity
When building hardware-software systems, we fundamentally rely on modularity at
component boundaries to manage complexity. For example, a PCIe device can
connect to any machine with PCIe, and a modern Ethernet device does not need to
know what component it connects to. We apply the same idea for simulating
complex systems: the **structure of the simulation corresponds to the structure
of the simulated system**, and we **interface different component simulators at
natural interfaces for the physical system**. Two common SimBricks interfaces
are PCIe and Ethernet. A PCIe device simulator can connect any simulator
implementing the PCIe host interface. An adapter for a SimBricks interface only
has to be implemented once when initially integrating the simulator. This
enables the modular "Lego" combination and swapping of components.


# Component Simulators as Separate & Parallel Processes
To make it easy to integrate independently implemented simulators, potentially
in different programming languages and with incompatible simulation modes,
SimBricks runs individual component simulators as separate independent processes.
As a result, integrating a simulator into SimBricks only requires the developer
to add adapters for the specific interfaces, and to match these up with that
simulator's internal abstractions, but no complicated structural changes are
needed. This reduces the complexity of integration to each simulator ensuring
compatibility with the SimBricks interface, rather than with all other
simulators.

Running component simulators as separate processes also trivially enables
parallelism between components. **A system with more components** thus requires
additional processor resources but **does not increase simulation time**
significantly.

# Efficient Message-Passing
The independent component simulator processes of course need to communicate. To
retain loose coupling, we implement this through message-passing. For efficiency
and scalability, SimBricks relies on **pairwise message-passing channels between
simulators that simulate connected system components**.  Most component
simulators thus only directly communicate with one or two peers, e.g. a machine
might have one or two PCIe devices, a PCIe NIC connects to the host on one port,
and the network on another, etc.

Message transfers are also on the critical path, and have the potential to slow
down already slow simulators. To minimize message transfer overhead, we rely on
**polled shared memory queues**. As long as simulators run on separate cores,
this enables cheap and low-latency message transfers without kernel involvement.
We will discuss the details and implications in much more detail in a future
post.

# Accurate & Scalable Synchronization
Once simulators can communicate at component interfaces to exchange data, we can
run functionally correct and efficient full system simulations. However, these
simulations do not produce meaningful performance measurements, as each
simulator process has its local simulator clock advancing at an independent
pace. In general, **meaningful performance results require synchronized clocks
across all component simulators**. Achieving this efficiently and at scale is a
challenge.

SimBricks addresses this with **synchronization inlined with message transfers
by tagging messages with timestamps**. We only synchronize communicating peer
simulators — correctness only requires that each simulator process incoming
messages at the correct time. A message with a particular timestamp is a promise
that no older messages will arrive on that channel, and thus the simulator can
safely advance to that time. A modeled interface delay creates wiggle room
critical for performance, simulators do not need to operate in perfect
lock-step. Dummy messages ensure progress when no data messages are exchanged.
This combination enables efficient and scalable synchronization without
sacrificing accuracy.

# Orchestration Framework: Assembling Bricks
Manually starting and running such a simulation with many pieces, is
prohibitively complicated and laborious. SimBricks automates this with our
orchestration framework, the main means for users to interact with SimBricks and
our simulations. The orchestration framework, **allows users to specify
simulation configurations as Python scripts**, typically 10-200 lines.
The framework then fully **automatically configures and runs all simulators**.
Moreover, the simulation configurations can leverage pre-configured components,
enabling reuse and avoiding the need for each user to understand each simulator
configuration in-depth.


We look forward to covering these pieces in more detail in future posts. Until
then:
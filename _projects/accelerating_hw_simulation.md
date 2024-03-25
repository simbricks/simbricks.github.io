---
title: Accelerating cycle-accurate hardware simulation
description: |
  Leveraging cycle-accurate abstraction through latency petri nets to accelerate hardware simulation
people:
  - jiacheng
  - jonas
---

Special purpose hardware can achieve significantly higher performance and energy
efficiency than traditional general-purpose processors and is therefore going to
be widely used to offload computations in machine learning, video de-/encoding
and de-/encryption workloads. The choice which accelerator is best suited for a
concrete system as well as which parts of the workload to offload is non-trivial
though. We have to make well-informed decisions to not end up performing worse
than the software-only baseline. Furthermore, purchasing special purpose
hardware for benchmarking is not only expensive in terms of up front costs but
also time-intensive to port the code. Instead, we could turn to full-system
simulation in SimBricks but simulating RTL code in a cycle-accurate manner is
very slow. Vendors also typically don't release the source code to protect their
intellectual property (IP).

Latency petri networks (LPNs) extend classical petri nets to pose as performance
interfaces for hardware accelerators, i.e. they take the same input as the
accelerator and return the corresponding latency for the individual outputs.
Fundamentally, they *only* model latency and don't concern themselves with
functionality. This way, the hardware accelerator's latency can be represented
very efficiently in terms of lines of code, while yielding simulation speeds on
par with purely functional simulators and also preserving cycle-accuracy.
Furthermore, since LPNs are abstract, they arguably leak no more information
about IP than a block diagram of the circuit. Additionally, a hardware engineer
writing them has the same mental model as when developing RTL. Hence, it is
viable for hardware vendors to offer LPNs alongside their hardware accelerators.

We propose a transparent drop-in replacement (the rest of the system won't
notice) for cycle-accurate RTL simulators that combines an LPN and a functional
model to significantly speed up the overall simulation. In full-system
simulations like SimBricks, the slowest component limits the overall simulation
speed due to synchronization. As soon as we introduce a cycle-accurate hardware
simulator, it will pose as the bottleneck. With this work, we provide a
methodology on how to use LPNs in full-system simulations and define a
standardized interface between functional simulator and LPN since latency is
data dependent and the two components therefore have to communicate, i.e. the
functional model fetches the data and forwards information about it to the LPN,
which then computes the hardware accelerator's latency.
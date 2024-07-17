---
title: "Streamline Your Chip Design with SimBricks"
subtitle: |
  How can SimBricks help make chip design faster, cheaper, and lower risk?
date: 2024-07-17
author: jakob
permalink: /blog/chip-design-flow.html
card_image: /assets/images/blog/chip-design-flow.png
---

In today's blog post we explore how SimBricks can help accelerate the design,
implementation, and validation of chips for modern computer systems. Custom
chips tailored to specific tasks offer significant performance gains and lower
power consumption compared to general-purpose processors, but building them is
an expensive and slow process. They are widely used from data centers to
everyday devices, and are typically a small part of a larger system of many
components. SimBricks provides early and continuous feedback throughout the
process by enabling true full simulations, thereby accelerating the process.


# Specification and Architectural Design

![Example of a behavioral SimBricks simulation with gem5 connected to a SystemC
model and an ns-3 simulated network.](/assets/images/blog/asic-design-flow-behavioral.svg)

SimBricks shines already in the early stages of chip design, where system and
hardware architects define core functionality and break down the overall system
into manageable blocks. SimBricks can simulate connected hardware and software
components of the complete system to support early design activities.

## Full-System Architecture Exploration
Architectural choices in the new chip often substantially affect overall system
performance. Instead of only relying on analytical system models that are likely
to miss details significantly affecting system performance, SimBricks enables
system architects to do architectural exploration with reliable full-system
results, by integrating high-level SystemC models for the new chip with existing
simulators for the remaining system components. This integration only requires
adding [lightweight adapter
components](https://simbricks.github.io/blog/loosely-coupled-simulator-processes.html)
to the SystemC model. For example, a SystemC model could integrate with attached
machines (e.g. simulated by QEMU, gem5, Simics), running Linux and real
applications, other attached hardware components (e.g. NICs, SSDs), or the
network itself (e.g. simulated by ns3, OMNeT++).

## Hardware-Software Co-Design
Modern computer systems rely on closely integrated hardware and software
components which ideally should be designed together. SimBricks enables system
architects to explore design choices in both hardware and software as well as
their interaction, as the simulations include processors and other components
running software.

## Virtual Platform for Software Development
These systems also require substantial software development effort, however many
software components are difficult to test before hardware is available.
SimBricks can provide virtual platforms to speed-up software development and
enable early integration testing, enabling parallel software and hardware
development at the earliest stages. This is also particularly useful for
developing components at the boundaries such as device drivers.


# RTL Implementation and Verification

![SimBricks simulation with a gem5 host, RTL simulation in verilog, and an ns-3
simulated network.](/assets/images/blog/asic-design-flow-verilator.png)

SimBricks continues to add value beyond the early design stages by integrating
RTL simulation into full systems. RTL simulators such as Verilator or Vivado
xsim, can integrate into full system simulations similar to the SystemC models
earlier. Generally this requires some minimal design-specic adapters to connect
wires on the top-level module through the SimBricks component interface. To make
this easier, SimBricks already provides a few reusable building blocks, such as
different AXI adapters. This helps streamline RTL implementation.

## End-to-End RTL Testing
Instead of only simulating RTL in isolation with testbenches, SimBricks enables
continuous integration tests of the RTL implementation into the full system. In
addition to enabling early integration tests, this can also substantially reduce
time otherwise needed for complex testbench code and help testing the in very
complex situations and workloads, which would be prohibitively complex to
implement as testbenches.

## Early RTL Performance Testing
In addition to functionality, this also enables early performance testing of the
RTL within the full system. This helps hardware engineers evaluate the impact of
even low-level implementation choices on bottom-line system performance. This
helps identify important issues early, and separating them from local
performance problems that do not actually impact overall system performance at
all.


# Post-Synthesis Validation
There are even potential benefits to using SimBricks after synthesis. The
starting point here is to integrate gate-level simulators into SimBricks to full
system. Just like previous stages, a custom adapter allows seamless integration.
This enables validating fully implemented designs in the context of the complete
system. Additionally, gate-level simulations as part of a full system can help
to obtain more reliable energy and thermal estimations based on real workload
characteristics.

Overall our comprehensive full-system simulation approach, powered by SimBricks,
leads to a more efficient design process through more reliable and accurate
simulation results that can be used to optimize the proposed chip early on. We
have some concrete examples of this in our
[GitHub repositories](https://github.com/simbricks).
Please reach out if you would like to learn more:
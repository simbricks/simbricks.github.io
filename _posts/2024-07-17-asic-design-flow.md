---
title: "Fast-Forward Your ASIC Design with SimBricks" 
subtitle: |
  How can SimBricks help during the design process of an ASIC?
date: 2024-07-17
author: jakob
permalink: /blog/fast-forward-asic-design-with-simbricks.html
card_image: /assets/images/blog/TODO
---

With Moore's Law slowing down, general-purpose processors are slowly reaching their performance limits. In today's blog post we explore how SimBricks can help during the design phase of Application-Specific Integrated Circuits (ASICs). ASICs are custom chips tailored to specific tasks, offering significant performance gains and lower power consumption compared to general-purpose processors. They are widely used from data centers to everyday devices. SimBricks provides early and continuous feedback throughout the design flow by enabling true end-to-end simulations, thus accelerating the entire process.


# Specification and Architectural Design

![sjjdgholds](/assets/images/blog/asic-design-flow-behavioral.svg)

SimBricks shines already in the early stages of ASIC design, where you define core functionalities and break down the overall system into manageable blocks. Here's how it streamlines the process:
Easy Integration: Your high-level C++/SystemC models seamlessly integrate with SimBricks using lightweight adapters (explained in a previous [post](https://simbricks.github.io/blog/loosely-coupled-simulator-processes.html)).
End-to-End Functional Testing: Simulate the ASIC's peripherals just like in a real system, enabling testing with unmodified applications. This facilitates early interface verification and allows software development to run in parallel with hardware design.
Driver Development & User Interaction Testing: Teams can develop drivers and test how users will interact with the final hardware – all while the ASIC is still under development.
Since SimBricks allows real software and connected components to be simulated, it is possible to test various design decisions and their effects on the overall system already starting at the early stage of the development process and thus accelerating the ASIC design process early on.


# RTL design and Verification

![sljdgbdsfjgbkl](/assets/images/blog/asic-design-flow-verilator.png)

SimBricks extends its value beyond the early design stages. Here's how it simplifies RTL verification after the ASIC was designed using a Hardware Description Language (HDL) like Verilog, VHDL or System Verilog:
RTL-Level SImulation Integration: Integrate your RTL simulations seamlessly using simulators like Verilator or Vivado Xsim which are already supported through SimBricks AXI adapters. Similarly, SimBricks allows the integration of other simulators like Synopsys VCS through the implementation of custom adapters using e.g. an AXI or PCIe interface. Integrating new simulators into SimBricks often only involves writing a lightweight adapter (similar to the C++/SystemC case).
End-to-End RTL Testing: Simulate and test not just functional models, but also your RTL code end-to-end. This allows for early performance testing within SimBricks.
Meaningful Performance Insights: Simulating peripherals in SimBricks, e.g. an attached machine (e.g. QEMU, gem5, Simics), running unmodified Linux and an application, other attached hardware components (e.g. Tofino, FEMU SSD), or the network itself (e.g. ns3, OMNeT++), provides more realistic results compared to isolated simulations. This early performance data empowers informed decision-making throughout the ASIC design process.
By integrating the toolchains you already use, SimBricks facilitates a smoother and more efficient design flow. As verifying the design at this stage is a time consuming task, SimBricks speeds up this process by making verifying the design more easy and accurate. Especially being able to simulate the ASICs peripherals in detail, thus reflecting interactions between the involved components allows users to more easily identify potential bottlenecks e.g. communication overheads rendering increasing the chip size further infeasible.


# Synthesis 

SimBricks continues to empower your design flow even after logic synthesis:
Gate-Level Simulation Integration: Simulate your design at the gate level using tools like Vivado Xsim. Just like previous stages, a custom adapter allows seamless integration of gate-level simulations into SimBricks.
Enhanced Accuracy & Early Issue Detection: Gate-level simulations within SimBricks provide an even more realistic view of the circuit's behavior compared to RTL simulations, enabling earlier detection of timing, power, or other low-level issues. Again, SimBricks allows simulating the peripherals of an ASIC. This, for example, enables more meaningful and accurate power usage estimations because Simbricks allows to run real application workloads during the simulation.
This comprehensive simulation approach, powered by SimBricks, leads to a more efficient design process through more reliable and accurate simulation results that can be used to optimize the proposed chip early on.
If you’re interested in using SimBricks when designing your ASIC check out our [GitHub repositories](https://github.com/simbricks). Until then: 

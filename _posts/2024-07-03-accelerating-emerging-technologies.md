---
title: "Build Systems around Emerging Technologies Faster with SimBricks"
subtitle: |
  Modular full-system simulation is particularly useful for disruptive
  systems with even longer time to deployment.
date: 2024-07-03
author: antoine
permalink: /blog/accelerating-emerging-technologies.html
card_image: /assets/images/blog/technical-overview.jpg
---

The future of computing is increasingly heterogeneous and substantial
performance, cost, and efficiency improvements also require disruptive changes
in the underlying technology — be it moving specific computation to analog or
photonic chips or even to quantum computers, dis-aggregating processors, memory,
accelerators, and storage and then flexibly assembling servers via CXL, or
re-shuffling the entire HW-SW stack for network communication with
UltraEthernet.

![Slow HW Design timeline before SimBricks, 1-2 years with feedback only at the
end.](/assets/images/blog/build-emerging-without.jpg)

# Building with Emerging Technologies is Slow and Expensive
Building these new systems is a process rife with challenges resulting in,
increased risk, slow development, and high costs. The key underlying problem is
the **combination of radical changes to multiple system components and their
interaction and a particularly long route to physical prototypes and
deployments.** Radical changes make it extremely challenging to predict overall
system performance, the bottom-line metric that matters at the end of the day.
Consequently, reliable results only become available once a complete system
prototype, typically a complete physical deployment, is in place to measure and
evaluate. Unfortunately, reaching that point, especially with emerging
technologies in the mix, often takes years.


# Speed Up, De-risk, and Lower Cost with Virtual Prototypes
What if you could drastically shorten this process? What if building
heterogeneous systems, even with emerging technologies, could be approached in
the same agile and iterative way we build software? With SimBricks we enable
rapid virtual system prototyping of potentially highly complex systems with many
different components. SimBricks allows users to run complete virtual system
prototypes in simulation early in the development process when a physical
prototype is still long out of reach. To make this possible for complex systems
SimBricks allows users to combine and connect a range of simulators for system
components into a complete testbed.

![Accelerated HW Design timeline with SimBricks, with continuous feedback from
early prototypes.](/assets/images/blog/build-emerging-with.jpg)

## Enabling Reliable and Fast Early Design Exploration
System or hardware architects can assemble virtual prototypes early before
finalizing system design. The prototypes enable architects to explore the impact
of different system- or component-level design choices on overall system
performance, including complete software stacks with real applications and
workloads. Having a reliable means of evaluating design choices based on the
bottom-line metric of interest, enables architects to make better design choices
and make them faster.

## Virtual Prototypes Streamline the Development Process
The virtual prototype continues to serve as a valuable tool after early design
exploration by serving as a tool for agile, fast, and iterative development.
During implementation, hardware and software engineers can incrementally refine
the initially often abstract simulation models of respective new system
components into complete detailed implementations step by step. The virtual
prototype enables different teams of software and hardware engineers to run
integration tests early and continuously. As such, SimBricks can help build
bridges between different teams and enable more agile development across the
complete system.

# Use-Case: Building new Analog AI Accelerator
As an example use case, consider a company building a new AI accelerator based
on analog computing to improve energy efficiency by orders of magnitude. Analog
computing as a (re-) emerging technology holds great promise, but the road to a
complete system with such a disruptive technology is much longer than with a
conventional digital chip. Many high-level design questions remain open: Which
processing should be done in analog circuits? How does the analog circuit
integrate into the rest of the system? What remaining processing is best done in
software and what in conventional digital logic close to the interface? What
performance is required of the individual components? All of these questions
need to be decided based on impact on the bottom line overall system
performance.

With SimBricks, the system architect can start exploring these questions in a
virtual prototype and get early full system results. For this, we integrate the
high-level models already commonly used today as part of this process, into a
full virtual prototype. SimBricks does not replace the need for
technology-specific simulation models for the new system components but instead
allows the user to integrate these with other existing components into a
complete system. As development continues from there, software engineers can
refine software components and drivers, digital chip engineers can test RTL
against the rest of the system, and finally, the analog hardware team also has a
means for early integration tests based on their analog circuit simulations.

# Use-Case: Building UltraEthernet Components
Another example is the development of components for the upcoming new
UltraEthernet standard for HPC and datacenter networks. UltraEthernet aims to
efficiently connect servers, switches, and in-network accelerators, based on a
cross-stack re-design of today's protocols. A key goal for UltraEthernet is
tight and efficient integration across software and hardware components. As a
result, anyone building on UltraEthernet, be it individual component vendors, IP
vendors, or vendors for complete systems need a reliable means of understanding
the resulting system performance for different designs. This requires prototypes
with many servers, switches, accelerators, and also realistic network
conditions. SimBricks allows developers of individual UltraEthernet products
to quickly explore and develop using virtual prototypes of complete systems.

If you are interested in how SimBricks can help you build faster, please reach
out:
---
title: "Modern Systems Require Full-System Simulation"
subtitle: |
  Why should you care about end-to-end evaluation in simulation?
  How can SimBricks help you conduct end-to-end evaluations?
date: 2024-06-24
author: marvin
permalink: /blog/need-for-e2e-simulation.html
card_image: assets/images/blog/need-for-e2e-evaluation.jpg
---

In our previous blog post we had a look at how SimBricks enables modular full
system simulation. By combining different best-of-breed simulators, SimBricks
effectively enables end-to-end evaluation in simulation. But why should you care
about full system simulations instead of sticking with the status quo of
simulating only specific parts of the system in isolation? This post sheds light
on when and why you should care about end-to-end evaluation.


# Full System Simulation Provides the Whole Picture
Modern computer systems consist of many interconnected components. For example,
CPUs might be connected to memory, NICs, GPUs, and much more. Networks are
naturally highly interconnected systems that consist of many different
components. And the trend towards increasingly interconnected systems is
continuing with the advent of new technologies such as hardware resource
disaggregation. Thus individual components rarely operate completely detached
from the rest of the system. Instead, the decisive factor for the behavior and
performance of a component is often how it interacts with other components in
the system.

For example, if we develop a new accelerator that is connected via PCIe, it is
of no benefit if the accelerator can perform calculations quickly and
efficiently, but cannot communicate efficiently with the rest of the system. In
this case, the interface to the rest of the system becomes a bottleneck and
prevents the accelerator from reaching its true potential. Therefore, a
meaningful evaluation of these systems, requires us to look at all system
components in combination.


# Existing Individual Simulators Are Not Enough
Current simulators only simulate parts of most typical systems today. Different
simulators focus on simulating different subsets of system components. They
either completely skip simulating other components, or rely on overly simplified
or abstracted models for them. For example, the network simulator
[ns-3](https://www.nsnam.org/), simulates the behavior of a network well, but
only uses a very abstract, functional model for the end-hosts. Many aspects of
the host systems are not modeled, even though they can have a noticeable effect
on the performance of the entire system. We therefore use SimBricks to simulate
each relevant component in detail with a separate best-of-breed simulator. This
allows us to perform actual end-to-end full-system evaluation in simulation.




# End-To-End Evaluation Makes a Difference

![Example of difference between network simulation and end-to-end simulation.](/assets/images/blog/dctcp-graph.png)


To show that end-to-end simulation can make a difference, let's look at an
experiment we conducted in our paper. In this experiment we compared the dctcp
congestion control algorithm in the ns-3 network simulator to a physical testbed
and SimBricks end-to-end simulation. We set up two clients and two servers
sharing a bottleneck link and one large TCP flow for each client-server pair. In
the case of SimBricks, we use a combination of gem5, ns-3 and an Intel i40e NIC
simulator to simulate hosts, network and NICs in detail. The graph above shows
the throughput for varying the dctcp parameter K. The marking threshold balances
queuing latency and throughput; a lower threshold reduces queue length but risks
under-utilizing links. Ns-3 underestimates the necessary threshold to achieve
line rate, as it does not model host processing variations, particularly
processing delay caused by OS interrupt scheduling. However, SimBricks uses gem5
for a detailed simulation of the host and thus captures host processing
variations resulting in measurements that more closely match with those of the
physical testbed. We conclude only an end-to-end evaluation of the full system
captures such intricacies.

We hope that we have been able to convince you that you should conduct
end-to-end evaluations using full system simulations. If you have any question:

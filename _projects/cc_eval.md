---
title: End-to-End Congestion Control Testbed
people:
  - marvin
description: |
  Framework for evaluating congestion control algorithms in end-to-end
  simulations
---

Congestion control is a fundamental corner stone of networks and is still
actively researched. To evaluate and test new or established congestion control
algorithms, researches usually resort to simulations. However, while popular
network simulators like ns-3 are good at simulating the network itself, they
lack a detailed simulation of the (end-)hosts. Hosts are typically simulated
only in a high-level behavioral manner, which can neglect important behaviors,
e.g. latency introduced by the operations of the Linux networking stack and
caching effects. In this sense, network simulators do not provide detailed
end-to-end simulations.

Using SimBricks, we can overcome these limitations by combining multiple
simulators into a detailed end-to-end virtual testbed (e.g. simulating the network
with ns-3 and the hosts with gem5). This project aims to build a framework that
makes it easy to build, configure and run congestion control experiments in
SimBricks. Furthermore, we want to investigate whether (and in which cases)
detailed end-to-end simulations in SimBricks achieve better/more realistic
results than pure ns-3 simulations.
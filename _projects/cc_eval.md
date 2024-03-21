---
title: End-to-End Congestion Control Testbed
people:
  - marvin
description: |
  Framework for evaluating congestion control algorithm in end-to-end
  simulaitons.
---

Congestion control is a fundamental corner stone of networks and it is still
part of active research. To evaluate and test new or adapted congestion control
algorithms, researches usually resort to simulations. However, while popular
network simulators like Ns3 are good at simulating the network itself, they
lack, for example, a detailed simulation of the hosts. The hosts are typically
simulated only in a high-level behavioral manner, which may neglect certain
behaviors, e.g. caching behavior. In this sense, network simulators do not
provide detailed end-to-end simulations. Using SimBricks we can overcome these
limitations by combining multiple simulators into detailed end-to-end
simulations (e.g. simulating the network with Ns3 and the hosts with Gem5). This
project aims to create a testbed that makes it easy to build, configure and run
congestion control experiments in SimBricks. Furthermore, we want to investigate
whether (and in which cases) detailed end-to-end simulations in SimBricks
achieve better/more realistic results than pure Ns3 simulations.
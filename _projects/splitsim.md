---
title: SplitSim
people:
  - hejing
description: |
  Accelerate simulators by decomposing them into parallel synchronized
  components.
---

Accelerating simulators by parallelization is a promising approach. Yet, it is
challenging to parallelize and do it in an efficient and scalable way while
preserving timing accuracy. To this end, we present a multi-process simulation
framework SplitSim. Motivated by SimBricks, SplitSim provides a method to
systematically decompose a large instance of simulation into several pieces and
run them in parallel, while safeguarding accurate timing. What’s more, it is
flexible in terms of deciding the number and the scope of divided pieces. We are
adopting SplitSim to several representative simulators, including ns-3 and gem5,
in the network area and computer architecture area respectively.
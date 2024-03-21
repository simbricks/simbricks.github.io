---
title: AC/DSim
logo: projects/acdsim.svg
people:
  - jonas
description: |
  End-to-End Energy Estimation through Modular Full System Simulation.
---

SimBricks enables us to measure full system performance numbers like end-to-end
application throughput and latency for custom hardware designs such as
offloading computations from the CPU through full system simulation. However,
energy consumption is often an equally important metric. For example, we might
be interested in the amount of energy we save compared to running our workload
in software only. Additionally, when designing this hardware, we want to make
well-informed decisions for tuning design parameters that trade off speed or
computational capabilities and energy consumption. Therefore, we need to be able
to evaluate the design early in the process. Considering that energy consumption
is spread across all the system's components and also changes dynamically based
on the workload, we use SimBricks for full-system simulation running real
applications and the actual workloads. We take a modular approach by estimating
the energy consumption individually for the different components and afterwards
summing them up into complete-system numbers. Luckily, there already exists work
for estimating energy consumption for many of the component simulators which we
can make use of.

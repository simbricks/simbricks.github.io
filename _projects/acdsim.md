---
title: AC/DSim
logo: projects/acdsim.svg
people:
  - jonas
description: |
  End-to-end energy estimation through modular full-system simulation
---

SimBricks enables us to measure full-system performance numbers like end-to-end
application throughput and latency for custom hardware designs, such as
offloading computations from the CPU, in simulation. However, energy
consumption is often an equally important metric. For example, we might be
interested in the amount of energy we save compared to running our workload in
software only. Furthermore, when designing this hardware, we want to make
well-informed decisions for tuning design parameters that trade off speed or
computational capabilities and energy consumption. Therefore, we need to be able
to evaluate the design early in the process.

Considering that energy consumption is spread across all of a system's
components and also changes dynamically based on the workload, we need dynamic
information to make an accurate energy consumption estimation. We can collect
this during simulation without perturbing the workload.

 Overall, we take a modular approach by estimating the energy consumption
individually per component and afterwards summing up into one number for the
complete system. To this end, we use SimBricks to run the unmodified application
and actual workload. We instrument the full-system simulation to collect the
information necessary for accurate energy estimation and draw on existing work
for estimating the energy consumption of component simulators like
[GemStone](https://web-archive.southampton.ac.uk/gemstone.ecs.soton.ac.uk/gemstone-website/gemstone/index.html)
and the power analysis tools from hardware tool chains. Herein, timing
information from the simulation can be used to compute energy numbers from tools
that only provide power estimates.
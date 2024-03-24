---
title: Columbo
logo: projects/columbo.svg
people:
  - jakob
description: |
  Low-Level End-to-End System-Traces through SimBricks Simulations.
---

Simulation can provide almost arbitrary deep visibility into what a simulated
system does **without affecting** the simulated systems behaviour at all.
Additionally do most simulators provide the capabilities to write detailed log
files. 
The goal of [Columbo](https://github.com/q713/simbricks/tree/log-analysis) 
will be to add library support to SimBricks that allows users to easily write small programs to
obtain **Low-Level End-to-End System Traces** of SimBricks simulations by
harnessing the log files that are written by the simulators involved in a
simulation. 
To achieve this the log files are combined and converted into
already existing formats known from distributed tracing: Events, Spans, Traces.
This will be useful tooling for people using SimBricks as it will help to easily
answer questions like what was the average end-to-end latency within a
simulation and how was this latency distributed across individual components or
why did RPC X take Z ms longer than RPC Y. In more detail are the individual log
files parsed to obtain Events that will be packed together to Event-Spans for
each simulator respectively. These event spans will then be causally connected
to each other to form a distributed trace. To benefit from this, existing tools
from the distributed tracing community (like
[Jaeger](https://www.jaegertracing.io/)) are used to visualize and query the
resulting traces. 

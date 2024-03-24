---
title: Columbo
logo: projects/columbo.svg
people:
  - jakob
description: |
  Interpretable, end-to-end system traces from SimBricks simulations
---

Simulation can provide almost arbitrary deep visibility into what a simulated
system does *without affecting* the simulated system's behavior. Additionally,
most simulators provide the capability to produce highly detailed log files.
[Columbo](https://github.com/q713/simbricks/tree/log-analysis) adds library
support to SimBricks enabling users to write small programs to obtain a
*low-level* and fully *end-to-end* system trace from the log files that are
produced by the individual component simulators.

In this work, we heavily draw from the area of distributed tracing. We combine
the individual log files by converting them into commonly-known concepts like
Events, Spans, and Traces. This allows us to make use of distributed tracing
tooling to easily answer questions like what the average end-to-end latency
within a simulation is and how this latency can be attributed to the individual
components involved. This then, for example, helps explain why RPC X took Z ms
longer than RPC Y.

In more technical detail, we first parse the individual log files to obtain
Events. We then combine these into per-simulator Event Spans. Finally, we
causally connect the per-simulator Event Spans, i.e. we connect the Event Spans
in component X the caused a span of events in component Y. This forms the
distributed trace. Finally, we make use of existing tools from the distributed
tracing community like [Jaeger](https://www.jaegertracing.io) to visualize and
query the data for analysis.

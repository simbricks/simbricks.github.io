---
title: "Accurate, Efficient, and Scalable Simulator Synchronization"
subtitle: How does SimBricks synchronize 1000s of parallel simulators with minimal overhead?
date: 2024-07-26
author: jonas
permalink: /blog/accurate-efficient-scalable-synchronization.html
card_image: TODO
---

In SimBricks, we combine simulators with incompatible simulation modes like
discrete event simulation, cycle-by-cycle circuit simulation, and mathematical
models. To make this work, we stick with each simulators’ internal concept of
time. However, a necessary condition is that we can always calculate an absolute
timestamp for a simulator’s current progress. For cycle-by-cycle simulators for
example, we can use the clock period and multiply it with the number of cycles.

For meaningful performance measurements, we synchronize progress across
simulators using these absolute timestamps. We want to maintain full accuracy,
i.e. messages a simulator sends to any of its peers are always processed at the
exact timestamp, while also scaling to connecting 1000s of simulators with low
overhead. Our synchronization mechanism is based on the way we connect
individual component simulators into a coherent whole. Hence, I recommend
reading [this earlier blog
post](https://www.simbricks.io/blog/loosely-coupled-simulator-processes.html)
first. Concretely, we only synchronize simulators locally with the peer
simulators they directly connect to. Synchronization happens inline through the
same communication channels that also carry data between simulators. To avoid
having to synchronize every step, we exploit link latency for synchronization
slack without losing accuracy.

# Local Synchronization between Peers Is Accurate

Global synchronization, i.e. over and over putting barriers that make simulators
wait until everyone has caught up to the same timestamp doesn’t scale as it
incurs further overhead for every simulator added to the system. Instead, we can
exploit locality in the communication between simulators. Messages are exchanged
point-to-point through statically created communication channels and only
simulators for components which also talk directly to each other in the real
system, communicate.

In SimBricks, incoming messages are the one and only thing a simulator can
observe about its peers. Thus, the only requirement for accuracy is that
incoming messages are processed at the precise time. We annotate messages with
the absolute time when they have to be processed. Messages are exchanged through
our efficient, shared-memory queues, one for incoming and one for outgoing
messages. We ensure that inside these queues, timestamps always monotonically
increase. So the slowest simulator in the figure above can safely advance to the
minimum of the timestamps of the latest incoming messages from all its peers,
i.e. min(1000 ns, 400 ns, 200 ns) = 200 ns since it is guaranteed that no
messages that have to be processed earlier will arrive.

So far, this doesn’t guarantee liveness since a simulator needs incoming
messages to make progress and there isn’t always a data message. To solve this,
we introduce an additional SYNC message type, which our simulators send in the
absence of data messages.

# Efficiency by Exploiting Link Latency

With the mechanism described so far, simulators send either a synchronization or
data message every step and thereby execute in lock-step. Connecting 1000s of
simulators, even small variability in execution speed would globally block all
simulators. Let’s see how to fix this now.

In real systems, links between components have a propagation and some constant
processing delay, the sum of which we call link latency Δ. By capturing link
latency in SimBricks, we gain synchronization slack. A message produced at time
T only has to be processed at T + Δ. For example, if there’s only one peer
simulator and its timestamp is T = 1000 ns and Δ = 1000 ns, the message is
time-stamped with 2000 ns. As soon as we see that, we can safely advance to 2000
ns since we are guaranteed that we won’t later see a message with an earlier
timestamp. Also, to ensure liveness, we now only need to send a message every Δ
interval. In the figure above, our slowest simulator can safely advance from 350
to 400 ns, after which it has to wait for further incoming messages. So peer
simulator D limits the progress that A can make.

Overall, the best case we can achieve with SimBricks synchronization is to be as
fast as the slowest simulator. From our own research, we have shown that our
synchronization mechanism is indeed very efficient, providing negligible
overhead even if we scale to 1000s of simulators. Further, using the SimBricks’
approach to connect simulators, we can also decompose existing simulators into
multiple pieces, which thanks to synchronization slack can simulate in parallel.

# Disabling Synchronization for Fast Functional Testing

In case you don’t need accurate performance numbers, for example during
functional testing, SimBricks allows you to disable synchronization on a per
component basis. This way there are truly no synchronization overheads and
overall simulation speed matches that of the slowest component you need to wait
on for data. Here, every simulator advances time as quickly as possible and
disregards the timestamps on incoming messages, instead handling them as soon as
they are received.
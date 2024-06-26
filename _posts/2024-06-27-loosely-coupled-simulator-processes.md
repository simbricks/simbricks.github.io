---
title: "Loosely Coupled Simulator Processes for Parallelism and Easy Integration"
subtitle: "Our secret to scalably connect and integrate a range of independent
and often incompatible simulators into a coherent whole."
date: 2024-06-28
author: jonas
permalink: /blog/loosely-coupled-simulator-processes.html
card_image: /assets/images/blog/loosely-coupled-simulator-processes.png
---

We connect individual simulators by introducing adapters, which take simulators'
internal extensibility APIs and translate them to a suite of SimBricks boundary
protocols. These are based on real system component boundaries like PCIe and
Ethernet. Simulator-internal machinery remains untouched by running each
simulator as a separate process. By just adding an adapter, we can easily
integrate additional simulators over time.

Adapters are connected pair-wise and communicate through shared-memory message
passing. Together with our synchronization technique that uses link latencies
for a loose coupling between simulators, individual components can be simulated
in parallel for scalable simulation.


# Connecting Simulators through Adapters

![loosely-coupled-simulator-processes.png](/assets/images/blog/loosely-coupled-simulator-processes.png)

SimBricks connects simulators for a wide range of individual components written
in different programming languages, which possibly also operate incompatible
simulation modes like event-based and cycle-accurate simulations. To avoid
brittle and complex hacks, we fully maintain a simulator's internal structure
and run them in separate processes while establishing communication through
shared-memory message passing.

These simulators are often meant to be extended and already offer
simulator-specific APIs to do so. However, we'd also like to have modularity,
i.e. easily swap out the simulator on the other side of a connection. To avoid
having to bother with implementation details of simulator-specific APIs of
connected simulators, we introduce a layer of abstraction: Adapters take this
simulator-specific API and translate it to a natural boundary protocol that is
then exposed to the outside world. Natural boundaries are those that also appear
between components in real systems like PCIe or Ethernet.

# Simulator-Native Adapters Enable Easy Integration

An adapter acts as a native part of its respective simulator and executes in the
same process. It's also written in the same programming language and uses the
same tooling the simulator's user is already familiar with. For the
communication to the outside world, the core SimBricks library already offers
all necessary functions. Integrating additional simulators is therefore
straight-forward and mostly focuses around connecting the pieces. 

From the outside world, an adapter receives boundary-specific messages and
reacts by invoking simulator-internal functions as well as sending response
messages back. On the inside, the adapter reacts to simulator-internal events
and sends out messages for things that the other side has to handle.

Let's make this more concrete by looking at how we implemented a PCIe adapter
for the gem5 host simulator, which allows us to hook up PCIe devices simulated
by other simulators to a complete machine capable of booting Linux. Our adapter
inherits the respective C++ base class for PCIe devices. As part of this, it has
to implement certain callback functions, for example to handle read requests the
CPU sends to the device. Instead of responding directly, the adapter forwards
the request as a SimBricks message to the device simulator. In turn, the adapter
receives messages from the device like a DMA (direct memory access) request. The
adapter handles these by invoking the respective gem5-internal functions and
responding with another message if necessary. 

# Parallelizing Simulator Processes for Scalable Simulations

A simulator can have many adapters, however, an adapter is always connected to
exactly one other adapter. With this you can build arbitrary configurations
instantiating the same simulator as separate processes as often as you like.

The paradigm of leaving simulators' internals untouched especially applies to
each simulator still running its own internal clock. Together with our
synchronization protocol that works along the adapter-to-adapter connections and
uses link latencies for synchronization slack while maintaining accuracy,
components are loosely coupled and can be simulated in parallel. So if you
increase the size of your simulated system by including more components, you
have to spend more computational resources for the additional processes, but the
overall simulation time will only take a small hit.

Stay tuned for up-coming blog posts that shed more light on the outside
communication between adapters and our loose but accurate synchronization
technique. Until then:

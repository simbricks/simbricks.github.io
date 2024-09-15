---
title: " Parallelize Existing Simulator with SimBricks"
subtitle: Effectively and Flexibly Divide a Simulator into Parallel Pieces
date: 2024-09-18
author: hejing
permalink: /blog/parallelize-using-simbricks.html
card_image: TODO
---

SimBricks enables full-system simulation by connecting multiple simulators and
running them in parallel. Thanks to its loosely coupled architecture and
efficient communication mechanisms, the runtime of each simulator overlaps
significantly, making the overall simulation time highly scalable as more
components are added. However, despite this scalability, the simulation time is
still constrained by the slowest component in the system. This bottleneck often
occurs in the host simulator when simulating multiple cores, or in the network
simulator when handling large networks with a high volume of packet generation.
In this blog post, we discuss how SimBricks can be used to parallelize and
accelerate existing simulators, alleviating these bottlenecks. The key idea is
to divide the simulation into smaller pieces that balance the simulation load
based on the natural boundaries in real world, such as the memory bus between
the cores and the rest of the host. And then combine these pieces into a whole
using SimBricks adapters.

# Advantages of SimBricks compared to built-in parallelization solutions

## Parallelize without intrusive change 
Parallelizing an existing simulator is
challenging and often requires extensive modifications. However, with SimBricks'
modular architecture, simulations can be easily divided along natural
boundaries, such as Ethernet links or memory buses. By simply attaching a
lightweight SimBricks adapter to each piece, it can be seamlessly connected to
its peers, streamlining the process. 

## Scalable synchronization of processes 
Most simulators are discrete event-driven
simulators (DES). The main reason for the slowness of existing DES is the
sequential nature of event processing. All generated events must be processed in
chronological order, creating strong dependencies between them. Even if events
are distributed across multiple queues and handled by individual threads, the
cost of synchronizing these queues is high, which limits parallelization. With
SimBricks synchronization[link], each process only needs to synchronize with its
peer. By incorporating the modeled latency between components, processes do not
need to synchronize in lockstep, reducing the overhead of synchronization and
improving efficiency.

## Efficient communication channel 
Some simulators, such as ns-3, offer a way to
run simulations across multiple processes using Message Passing Interface (MPI)
for communication and synchronization. In contrast, SimBricks implements
efficient message passing through optimized shared memory queues[link]. This
approach minimizes potential slowdowns during communication between different
components, significantly improving performance.

# Example of parallelizing the existing simulators using SimBricks 
As an example,
we parallelized a gem5 process to simulate a host with multiple cores. In the
original configuration, all components run within a single process. Since core
simulation consumes most of the time, the overall simulation time increases as
more cores are added. To parallelize gem5, we separated each core and its
on-chip caches from the rest of the system, assigning them to individual
processes. The remaining system was placed in a separate process. Using
SimBricks adapters, we then combined these components into the same architecture
as before. This approach significantly improved simulation speed and scalability
as the number of cores increased.

If you are curious about more detail of parallelizing simulators using
simbricks, don’t hesitate to  


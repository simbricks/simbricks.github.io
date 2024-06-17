---
title: "SimBricks — An Overview"
subtitle: |
  What is SimBricks? Why and when should you use SimBricks?
  Get a first overview through in our inaugural blog post.
  You can look forward to future posts going into more detail.
date: 2024-06-17
author: antoine
permalink: /blog/simbricks-an-overview.html
card_image: /assets/images/blog/workflow-highlevel-overview.jpg
---

Hello World! It is my great pleasure to kick off our SimBricks blog. The plan
for the blog is to cover a range of topics around SimBricks, from use-cases,
through challenges and insights, all the way to the technical internals. This
post provides a high-level overview before future posts dive straight into
individual pieces.

# What is SimBricks?
**SimBricks is a simulation framework to make it easier to design, implement, and
evaluate heterogeneous systems** — hardware accelerators, network offloads,
quantum computers, etc. SimBricks started life as a computer systems research
project, a collaboration between [Jialin Li](https://www.comp.nus.edu.sg/~lijl/)
(National University of Singapore) and [Antoine
Kaufmann](https://antoine.systems/) (Max Planck Institute for Software Systems),
soon joined by [Hejing Li](https://hajeongee.github.io/). From there, SimBricks
grew into a complete open-source framework, useful far beyond research.
Recently, part of the team (Jonas, Jakob, Marvin, Antoine) has started exploring
commercializing SimBricks as a start-up.

# What Problem Does SimBricks Solve?

![SimBricks Workflow overview.](/assets/images/blog/workflow-highlevel-overview.jpg)

Our goal is to enable users to run and experiment with complete systems,
including all hardware components, OS, drivers, libraries, and applications, as
early as possible in the system development cycle. We thereby address a key
challenge in building heterogeneous systems: the extremely long feedback cycles
from early design to getting to **reliable full-system application-level
results**, the bottom-line metric system designers and operators aim to
optimize. Earlier feedback enables users to intelligently choose the right
design, or even perform systematic design exploration based on actual
application performance. During implementation, developers again benefit from
being able to run the complete system early and iteratively making changes and
observing their effects. **SimBricks thus lowers cost and risk for building
heterogeneous systems and speeds up the process**. Another way to look at it is
that SimBricks allows users to build hardware systems with agility closer to
building software.


# When Should You Use SimBricks?
**SimBricks will be useful for you if you can benefit from running full-system
tests on systems where a physical testbed is not readily available.** One
use-case is early functionality and performance tests for hardware component
designs (HW accelerators, network offloads, composable infrastructure pieces,
etc.). For such systems, SimBricks can also provide more reliable evaluation
metrics for systems that do not target physical deployments, e.g. in systems
research where taping out and bringing up chips is beyond the means of most
researchers. Another interesting use-case is exploration of system architecture
and design parameters, including the ability to explore counterfactuals such as
*"How does the system bottleneck change if link bandwidth improves by an order of
magnitude?"* or *"What happens to this distributed system's performance if we
double memory bandwidth in the servers?"*. SimBricks also provides an avenue of
evaluation for systems where a physical implementation will take particularly
long to prototype, e.g. large-scale analog or photonic computer chips or
quantum computers.

# How Does SimBricks Work?
**SimBricks enables full-system simulation of even complex systems with many
components by combining and connecting a range of different simulators for
individual components into complete simulated testbeds.** Instead of reinventing
the wheel, we leverage and build on a broad range of best-of-breed simulators
that are fantastic at simulating the components they target, and combine them to
simulate all components in a specific system. This results in a modular
architecture of Lego pieces.

![SimBricks Components and Simple Example System.](/assets/images/blog/simbricks-example.jpg)

SimBricks users then assemble these component simulators into virtual testbeds
with the SimBricks orchestration framework. The SimBricks orchestration
framework allows users to describe even complex topologies of component
simulators in just a few tens of lines of Python. SimBricks then automatically
spins up and runs the simulation. Under the hood, our highly optimized
communication and synchronization mechanism efficiently runs even large
simulations comprising many different pieces, potentially spread across multiple
physical machines.

# Getting Started With SimBricks
I hope this post piqued your curiosity! The good news is, you can dive straight
in and start using and playing around with SimBricks. We suggest you start with
our [example repository](https://github.com/simbricks/simbricks-examples) on
GitHub. This repo covers a few common tasks and how to do these with SimBricks.
If you have a working VSCode Devcontainer setup, then you can just clone [the
repo](https://github.com/simbricks/simbricks-examples) in VSCode, open it, and
click *re-open in devcontainer* when prompted. For quick testing, you can also
directly [open the repo in
codespaces](https://codespaces.new/simbricks/simbricks-examples/?quickstart=1),
or try the [interactive Jupyter notebook on
mybinder](https://mybinder.org/v2/gh/simbricks/labs/main?urlpath=git-pull%3Frepo%3Dhttps%253A%252F%252Fgithub.com%252Fsimbricks%252Fsimbricks-examples%26urlpath%3Dlab%252Ftree%252Fsimbricks-examples%252Ffirst-steps%252Ffirst_steps.ipynb%26branch%3Dmain).

If you run into problems or have any questions, please reach out through [our
Slack](https://join.slack.com/t/simbricks/shared_invite/zt-16y96155y-xspnVcm18EUkbUHDcSVonA)!

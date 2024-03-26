---
layout: about
header_color: green
subtitle: |
  Streamlining design, implementation, and evaluation of heterogenous
  systems through modular full system simulation.
no_page_title: true
permalink: /

---

{::options parse_block_html="true" /}
<div class="block-50">

## SimBricks: Full-System Simulation for Heterogeneous Systems
SimBricks is an open-source simulation framework that enables full end-to-end
evaluation of modern heterogeneous systems in simulation. Our primary aim is to
to enable rapid prototyping and meaningful performance evaluation. SimBricks
modularly combines and connects battle-tested simulators for different
components: machines (e.g. QEMU, gem5, Simics), hardware components (e.g.
Verilator, Tofino, FEMU SSD), and networks (e.g. ns-3, OMNeT++). SimBricks
simulations run unmodified full system stacks, including applications, operating
systems such as Linux, and hardware RTL.

</div>

{::options parse_block_html="false" /}
<div class="block-60">
<figure>
<img src="/assets/images/overview_sys.svg"
        alt="Example of a heterogeneous system configuration with three
        hosts, a server with the DPU being built and an SSD and two clients with
        regular NICs. All hosts are connected to a network of just one switch."/>
<figcaption>Simple heterogeneous system featuring a DPU under development.
</figcaption>
</figure>
</div>

{::options parse_block_html="true" /}
<div class="block-50">

## Late Full-System Evaluation Slows Development and Increases Risk
Heterogeneous hardware-software systems are complex, slow, and expensive to
build, in academia and industry alike. These systems aim to drastically improve
performance and energy efficiency of the *complete* system or application.
However, engineers can only measure overall system performance once all software
and hardware components have been implemented and manufactured. As a result, key
metrics for evaluating design and implementation are only available late in the
project lifecycle, once a physical testbed can actually be fully built.

</div>


{::options parse_block_html="true" /}
<div class="block-50">

## Early & Continuous Full-System Results Accelerates Building Heterogeneous Systems

Enabling developers to run and measure the full system early speeds up and
reduces risks for building heterogeneous systems. Developers can choose optimal
design parameters before implementation based on reliable metrics. Full-system
integration tests reduce the need for extensive hardware testbenches that merely
emulate the real behavior. And once the hardware implementation is complete, a
reliable full-system performance evaluation before manufacturing provides early
feedback to developers, reviewers, and customers.

</div>


{::options parse_block_html="true" /}
<div class="block-50">

## Modular Simulation Enables Early and Continuous Evaluation

Simulation generally enables early evaluation when a physical implementation is
out of reach. However, typical heterogeneous systems require a broad range of
components not supported by any individual simulator. To address this, we take a
modular approach of combining different best-of-breed simulators for the
individual components. We flexibly connect and synchronize multiple parallel
instances of these simulators into a broad range of complete, *end-to-end*
virtual testbeds.
</div>



{::options parse_block_html="false" /}
<div class="block-60">
<figure>
<img src="/assets/images/overview_sim.svg"
        alt="Example of a SimBricks simulation configuration with three
        simulated hosts, a server and two clients. We simulate the server in
        gem5 and connect to an SSD simulated through FEMU and a Corundum FPGA
        NIC simulated through Verilator. The two clients are simulated in QEMU
        and connect to a PCIe behavioral NIC model. All three hosts are
        connected through a network simulated in ns-3.">
<figcaption>A SimBricks simulation configuration for the system above.</figcaption>
</figure>
</div>

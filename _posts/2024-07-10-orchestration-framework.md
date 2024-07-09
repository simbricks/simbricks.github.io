---
title: Easily Run End-to-End Simulation with SimBricks Orchestration Framework
date: 2024-07-11
author: hejing
permalink: /blog/orchestration_framework.html
card_image: TODO
---
SimBricks runs end-to-end simulations by assembling multiple component
simulators running as parallel processes into full system simulations. Component
simulators in SimBricks communicate by passing messages through shared memory
queues. For more detail see our earlier [technical overview
post](https://simbricks.github.io/blog/technical-overview.html). Launching such
a multi-process simulation and manually collecting results from each simulator
can become extremely laborious, especially as the simulation scales to more and
more components.

The SimBricks orchestration framework simplifies configuring, launching, and
collecting results from component simulators in SimBricks simulations. All a
user needs to do is write a Python script that defines the simulation, including
the system topology, simulators to use, drivers, and applications to run. Then,
by simply running the simulation with the simbricks-run command, the SimBricks
orchestration framework handles the rest of the execution details.

Now, let’s look at a concrete (simple) example of a SimBricks orchestration
script. In this script, we set up two hosts connected to a switch via individual
NICs , and the client host configured to send a ping to the server. There is
iPython Notebook with another simulation example and more detailed introduction
[here](https://github.com/simbricks/simbricks-examples/blob/main/first-steps/first_steps.ipynb).
Feel free to explore it for a deepr understanding.

# Create an Experiment
First, let’s start with creating an experiment. 
```
from simbricks.orchestration.experiments import Experiment 
from simbricks.orchestration.nodeconfig import ( I40eLinuxNode, IdleHost, PingClient) 
from simbricks.orchestration.simulators import Gem5Host, I40eNIC, SwitchNet

e = Experiment(name='simple_ping') 
experiments = [e] 
```

# Create a Client Host
Then, create the Client host node and define which simulator (gem5 here) to run
it plus the software we want to run in the Host. The SimBricks orchestration
framework has predefined classes for simulators and software configurations
(node & app config). Users can easily add new or modified configuration classes
through inheritance.
``` 
client_config = I40eLinuxNode()  # boot Linux with i40e
NIC driver client_config.ip = '10.0.0.1' 
client_config.app = PingClient(server_ip='10.0.0.2') 
client = Gem5Host(client_config) 
client.name = 'client' 
client.wait = True  # wait for client simulator to finish execution
e.add_host(client) 
```

# Create & Attach the Client’s NIC
Next, instantiate the NIC simulator and attach it to the host. 
``` 
client_nic = I40eNIC() 
e.add_nic(client_nic) 
client.add_nic(client_nic) 
```

# Repeat for Server Host and its NIC
Then, we repeat the same procedure for instantiating the server host and NIC: 
```
server_config = I40eLinuxNode()  # boot Linux with i40e NIC driver
server_config.ip = '10.0.0.2' 
server_config.app = IdleHost() 
server = Gem5Host(server_config) 
server.name = 'server' e.add_host(server)

server_nic = I40eNIC() 
e.add_nic(server_nic) 
server.add_nic(server_nic) 
```

# Connect the NICs to the Network
The last step is to instantiate the network simulator (simple switch here) and
connect the NICs of our hosts to it. 
``` 
network = SwitchNet()
e.add_network(network) 
client_nic.set_network(network)
server_nic.set_network(network) 
```

# Run the Script with SimBricks Package
Now, we have everything prepared, running the simulation is as simple as
invoking  the simbricks-run command: 
`simbricks-run --verbose simple_ping.py `

`simbricks-run` supports a number of  optional command line options to the
Simbricks runtime to control execution, set paths of inputs & outputs, etc..
After execution, you will find the aggregated simulation outputs from all
simulators in a JSON file, in the specific format for each component
simulatorWould probably be good to show an abbreviated output json
(pretty-printed) to give folks an idea what the output looks like.

By following these steps, you can build and run your own end-to-end simulation
and collect the results. You can experiment with different combinations of
simulators by simply changing the simulator type in the script, allowing you to
find the optimal balance between runtime and detail based on your development
needs. As orchestration scripts are just Python, all Python language features
(loops, functions, modules) are at your disposal to manage even complex
simulation configurations with ease.

Ready to try it out? We offer pre-built [docker
images](https://hub.docker.com/u/simbricks) and more detailed
[documentation](https://simbricks.readthedocs.io/en/latest/). For a quick start,
we suggest you head over to our example
[repo](https://github.com/simbricks/simbricks-examples) to help you get started.
In future blog posts, we will introduce how to set up a large-scale and
distributed simulation using the orchestration framework.  Stay tuned! And if
you have any questions until then please do not hesitate to reach out:


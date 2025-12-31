# frr-vitrine
A simple repo with example configs and topologies for network configuration with FRRouting and Containerlab

# Dependencie

## FRRouting

As if it wasn't clear enough, examples you can find here are only suited for [FRRouting](https://github.com/FRRouting/frr)
and no other networking suite.

The version used is:
- v10.4.1

## Containerlab

All examples from this repo uses [Containerlab](https://github.com/srl-labs/containerlab) to create the topology and simulate the network.

The version used is:
- v0.0.0
- commit 65917eb9

# Usage

If you wish to try out a scenario, you should first refer to the installation guide of containerlab at [](https://containerlab.dev/install/).

You will likely need to install docker and pull the image used here: 
- aperence/frr
- aperence/host

# Structure

This repository is organized a certain way. I hope it makes it better for navigation and finding what you search for.

common: contains templates and helpers for labs

protocols: focused on simple/atomic configs, specific to a single protocol (ISIS, OSPF, BGP, etc.)

scenarios: more complex examples for real-life/multiprotocol set ups (MPLS, L3VPN, etc.)


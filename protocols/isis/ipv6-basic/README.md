
# ISIS with IPv6

This document aims at describing the configuration of IS-IS with IPv6.
The goal is to enable simple connectivity inside the network.

## ISIS Process

The first thing to do when configuring IS-IS is to create and name the process:
`router isis <name>` 

The name is simply the name of the process used by other commands. 
It does not have a real purpose since *isisd* does not support multiple processes (see [FRRouting ISIS](https://docs.frrouting.org/en/stable-10.4/isisd.html#isis-router)).

Here we'll use 'core', so that we can reuse the same name in every configuration.

### Network Entity Name 

The network entity name (alias net) is an address used to identify the node inside the network.
This address has a variable length (from 8 to 20 bytes) and is divided in multiple bits:
- Variable IDP : used to identify the routing domain. You cannot really choose this, as it is provided by authorities.
Though, the identifier **49** is reserved for private networks. Hence why we use it.
- Variable DSP : 
    - High Order DSP (variable): correspond to the area number. Should be the same across all level-1 nodes belonging to the same area.
    - System ID (6 bytes): identify the node inside the area. Whatever but must be unique for the area.
    - NSEL (1 byte) : equivalent to a port number. Should always be **0** to indicate the node itself.

Therefore, we attribute a net to the node, inside the process:
```
net 49.0000.0000.0000.0001.00
```

See also [Introduction to ISIS](https://networklessons.com/is-is/introduction-to-is-is#:~:text=LSPs%2E-,NET%20%28Network%20Entity%20Title)

### Level 

We also need to attribute a level to the node.
There exist three types:
- level-1 : Knows intra-area topology
- level-2 : Knows intra-area topology and receives inter-area informations. **Backbone router**
- level-1-2 : Plays on both sides

Here, we use only level-1 nodes.
```
is-type level-1
```

See also [Introduction to ISIS](https://networklessons.com/is-is/introduction-to-is-is#:~:text=Areas%20and%20Router%20Roles,-IS)

## Interfaces

Once the IS-IS process is configured, we need to enable IS-IS on the interfaces that will exchange IS-IS control informations.

```
interface <name_interface>
    ipv6 router isis <name_process>
```

We also need to specify the type of connection:
- host/client : since the client will not directly participate in the IS-IS process, the interface connected to it should be qualified as "passive"
- router : routers are connected using point-to-point links, the associated interface follows this and is marked as "point-to-point"

About point-to-point network, it is important to enable it in order to have a more efficient and less memory demanding process.
The default behavior is to treat the connection as a multi-access network which results in the use of pseudonodes.
This only makes sense if we are dealing with an actual multi-access network, for point-to-point this behavior is inefficient.
See [ISIS on Point-to-Point Links](https://isis.bgplabs.net/basic/3-p2p/) (and [Multi-Access Networks](https://book.systemsapproach.org/direct/ethernet.html))

### Loopback

The loopback interface is treated a bit differently.

We give it an address using:
```
ipv6 address fc00:1::/32 
```
And since we want this to be the address used to contact the router, we need to enable IS-IS as well.
Thus, IS-IS is enabled to make sure the route is distributed across the network.

## Host

Concerning the hosts/clients, the set up is minimal. 
We simply configure their interface.

1. Give an address inside the block used for the local network
2. Set the interface up
3. Set a default route pointing towards the connected router

---
# References

[RFC 1195 - ISIS](https://datatracker.ietf.org/doc/html/rfc1195)
[FRRouting ISIS](https://docs.frrouting.org/en/stable-10.4/isisd.html)
[Introduction to ISIS](https://networklessons.com/is-is/introduction-to-is-is)
[ISIS on Point-to-Point Links](https://isis.bgplabs.net/basic/3-p2p/)
[Multi-Access Networks](https://book.systemsapproach.org/direct/ethernet.html)


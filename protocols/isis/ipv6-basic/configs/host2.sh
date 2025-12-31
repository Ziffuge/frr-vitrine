
ip -6 a add fc00:40c2::c2/32 dev eth1
ip link set dev eth1 up

ip -6 route add default via fc00:40c2::4 dev eth1

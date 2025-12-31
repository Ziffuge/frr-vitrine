
ip -6 a add fc00:10c1::c1/32 dev eth1
ip link set dev eth1 up

ip -6 route add default via fc00:10c1::1 dev eth1

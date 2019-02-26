#!/bin/bash

# Drop all current rules from iptables
iptables  -F
iptables  -X
iptables  -Z

ip6tables -F
ip6tables -X
ip6tables -Z

iptables  -t mangle -F
ip6tables -t mangle -F

##################################
########## FILTER TABLE ##########
##################################

# Allow access to/from loopback
iptables  -A INPUT  -i lo -j ACCEPT
iptables  -A OUTPUT -o lo -j ACCEPT
ip6tables -A INPUT  -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT

# Allow established and related, block invalid
iptables  -A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables  -A INPUT  -m state --state INVALID -j DROP
ip6tables -A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT
ip6tables -A INPUT  -m state --state INVALID -j DROP

# Blocked ip addresses
#iptables -A OUTPUT -s 1.2.3.4     -j DROP
#iptables -A INPUT  -s 1.2.3.4     -j DROP

# Allow Port
#iptables  -A INPUT -p tcp --dport 123  -j ACCEPT
#ip6tables -A INPUT -p tcp --dport 123  -j ACCEPT

# Privileged Management Network
iptables -N management_network
ip6tables -N management6_network

iptables  -A INPUT -s 1.3.3.7 -j management_network

iptables -A management_network -p tcp --dport 22 -j ACCEPT
iptables -A management_network -p icmp -j ACCEPT
ip6tables -A management6_network -p tcp --dport 22 -j ACCEPT
ip6tables -A management6_network -p icmp -j ACCEPT

# Default policy, drop everything coming in
iptables  -P INPUT   DROP
iptables  -P FORWARD DROP
iptables  -P OUTPUT  ACCEPT
ip6tables -P INPUT   DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT  ACCEPT

##################################
########## MANGLE TABLE ##########
##################################

# Mangle outgoing packets to have arbitrary TTL
iptables  -t mangle -A POSTROUTING -o ens3 -j TTL --ttl-set 111
ip6tables -t mangle -A POSTROUTING -o ens3 -j HL  --hl-set  111

# Save settings 
#iptables-save > /etc/network/iptables.up.rules
#ip6tables-save > /etc/network/iptables.up.rules

# Don't auto-save, check config before committing
echo "iptables-save > /etc/sysconfig/iptables"
echo "ip6tables-save > /etc/sysconfig/ip6tables"

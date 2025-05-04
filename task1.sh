#!/bin/bash

# Flush existing rules
iptables -F

# 1) allow incoming traffic on port 80 (HTTP) and port 443 (HTTPS)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# 2) block all other incoming traffic
iptables -P INPUT DROP

# 3) allow outgoing traffic on port 53 (DNS) and port 123 (NTP)
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT

# 4) block all other outgoing traffic not generated in response to approved incoming traffic
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -P OUTPUT DROP

# 5) enable logging for dropped packets
iptables -A INPUT -j LOG
iptables -A OUTPUT -j LOG

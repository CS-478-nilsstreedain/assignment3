#!/bin/bash

# Flush existing rules
iptables -F

# Default policies: drop all inbound and forwarded, allow all outbound from the firewall host
iptables -P INPUT   DROP
iptables -P FORWARD DROP
iptables -P OUTPUT  ACCEPT

# 1) Allow all outgoing traffic from the firewall/router server and the internal network, but block all outgoing traffic from the DMZ network, except for DNS and NTP.
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -p udp --dport 53  -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -p tcp --dport 53  -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -p udp --dport 123 -j ACCEPT

# 2) Allow incoming traffic on port 80 (HTTP) and port 443 (HTTPS) from the internet to the web server in the DMZ network, but block all other incoming traffic to the DMZ network.
iptables -A FORWARD -i eth0 -o eth2 -p tcp -d 10.0.0.10 --dport 80  -j ACCEPT
iptables -A FORWARD -i eth0 -o eth2 -p tcp -d 10.0.0.10 --dport 443 -j ACCEPT

# 3) Allow incoming traffic on port 21 (FTP) from the internet to the FTP server in the DMZ network, but only from a specific IP range (203.0.113.0/24).
iptables -A FORWARD -i eth0 -o eth2 -p tcp -s 203.0.113.0/24 -d 10.0.0.20 --dport 21 -j ACCEPT

# 4) Allow incoming traffic on port 22 (SSH) from the internet to the firewall/router server, but only from a specific IP address (198.51.100.1).
iptables -A INPUT   -i eth0 -p tcp -s 198.51.100.1 --dport 22 -j ACCEPT

# 5) Allow incoming traffic on port 25 (SMTP) from the internet to the mail server in the internal network, but only if the source IP address is in a allowlist file (/etc/iptables/smtp_whitelist.txt).
while read -r ip; do
  iptables -A FORWARD -i eth0 -o eth1 -p tcp -s "$ip" --dport 25 -j ACCEPT
done < /etc/iptables/smtp_whitelist.txt

# 6) Block all other incoming traffic from the internet to the internal network.
iptables -A FORWARD -i eth0 -o eth1 -j DROP

# 7) Enable logging for all dropped packets with a prefix "IPTables-Dropped: ".
iptables -A INPUT   -j LOG --log-prefix "IPTables-Dropped: "
iptables -A FORWARD -j LOG --log-prefix "IPTables-Dropped: "

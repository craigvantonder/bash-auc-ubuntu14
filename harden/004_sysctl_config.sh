#!/bin/bash

# IP Spoofing protection
sed -i 's/#net.ipv4.conf.all.rp_filter=1/net.ipv4.conf.all.rp_filter=1/g' /etc/sysctl.conf;
sed -i 's/#net.ipv4.conf.default.rp_filter=1/net.ipv4.conf.default.rp_filter=1/g' /etc/sysctl.conf;

# Block SYN attacks
sed -i 's/#net.ipv4.tcp_syncookies=1/net.ipv4.tcp_syncookies=1/g' /etc/sysctl.conf;
echo "net.ipv4.tcp_max_syn_backlog=2048" >> /etc/sysctl.conf;
echo "net.ipv4.tcp_synack_retries=2" >> /etc/sysctl.conf;
echo "net.ipv4.tcp_syn_retries=5" >> /etc/sysctl.conf;

# Ignore ICMP redirects
sed -i 's/#net.ipv4.conf.all.accept_redirects = 0/net.ipv4.conf.all.accept_redirects=0/g' /etc/sysctl.conf;
sed -i 's/#net.ipv6.conf.all.accept_redirects = 0/net.ipv6.conf.all.accept_redirects=0/g' /etc/sysctl.conf;
echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf;
echo "net.ipv6.conf.default.accept_redirects=0" >> /etc/sysctl.conf;

# Ignore send redirects
sed -i 's/#net.ipv4.conf.all.send_redirects = 0/net.ipv4.conf.all.send_redirects=0/g' /etc/sysctl.conf;
echo "net.ipv4.conf.default.send_redirects=0" >> /etc/sysctl.conf;

# Disable source packet routing
sed -i 's/#net.ipv4.conf.all.accept_source_route = 0/net.ipv4.conf.all.accept_source_route=0/g' /etc/sysctl.conf;
sed -i 's/#net.ipv6.conf.all.accept_source_route = 0/net.ipv6.conf.all.accept_source_route=0/g' /etc/sysctl.conf;
echo "net.ipv4.conf.default.accept_source_route=0" >> /etc/sysctl.conf;
echo "net.ipv6.conf.default.accept_source_route=0" >> /etc/sysctl.conf;

# Log Martians
sed -i 's/#net.ipv4.conf.all.log_martians = 1/net.ipv4.conf.all.log_martians=1/g' /etc/sysctl.conf;
echo "net.ipv4.icmp_ignore_bogus_error_responses=1" >> /etc/sysctl.conf;

# Ignore ICMP broadcast requests
echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf;

# Ignore Directed pings
echo "net.ipv4.icmp_echo_ignore_all=1" >> /etc/sysctl.conf;

# Disable IPv6
echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf;
echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf;
echo "net.ipv6.conf.lo.disable_ipv6=1" >> /etc/sysctl.conf;

# Randomize stack, vdso page and mmap
echo "kernel.randomize_va_space=1" >> /etc/sysctl.conf;

# Reload sysctl
sysctl -p;

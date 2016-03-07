#!/bin/bash

# Add New Hostname
echo "$hostname" > /etc/hostname;

# Clear the hosts file
> /etc/hosts;

# Update the hosts file with a fresh config
echo "127.0.0.1 localhost" >> /etc/hosts;
echo "$ipaddress $domainrecord $hostname" >> /etc/hosts;
echo "# The following lines are desirable for IPV6 capable servers" >> /etc/hosts;
echo "::1 localhost ip6-localhost ip6-loopback" >> /etc/hosts;
echo "ff02::1 ip6-allnodes" >> /etc/hosts;
echo "ff02::2 ip6-allrouters" >> /etc/hosts;

# Prevent IP spoofing
sed -i "s/order hosts,bind/order bind,hosts/g" /etc/host.conf;
echo "nospoof on" >> /etc/host.conf;
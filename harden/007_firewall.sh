#!/bin/bash

# Install Uncomplicated Firewall
apt-get install ufw -y;

# Disable IPv6
echo "# Disable IPv6
IPV6=no" >> /etc/ufw/ufw.conf;

# Change UFW behavior to deny connections by default unless passing the rules below
ufw default deny;

# Change log level to medium
ufw logging medium;

# Open HTTP and SSH ports
ufw allow 80/tcp;
ufw allow $sshport/tcp;

# Enable the firewall
ufw enable --force-enable;

# Show ufw status
ufw status verbose;
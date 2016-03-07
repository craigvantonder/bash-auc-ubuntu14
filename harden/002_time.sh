#!/bin/bash

# Configure the system time zone
echo "$system_timezone" > /etc/timezone;
dpkg-reconfigure -f noninteractive tzdata;
service cron restart;

# Enable NTP (Network Time Protocol)
apt-get install ntp -y;
update-rc.d ntp enable;
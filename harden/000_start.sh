#!/bin/bash

# Begin Installation
$installpath/001_update.sh;
$installpath/002_time.sh;
$installpath/003_hosts_config.sh;
$installpath/004_sysctl_config.sh;
$installpath/005_sshd_config.sh;
$installpath/006_adminuser_authentication.sh;
$installpath/007_firewall.sh;
$installpath/008_cleanup.sh;
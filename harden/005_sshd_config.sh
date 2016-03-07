#!/bin/bash

# Install openssh server
apt-get install openssh-server ssh -y;

# Customise the port for security reasons
sed -i "s/Port 22/Port $sshport/g" /etc/ssh/sshd_config;

# Ensure SSH listens only on IPv4
sed -i "s/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g" /etc/ssh/sshd_config;

# Disable root login
sed -i "s/PermitRootLogin without-password/PermitRootLogin no/g" /etc/ssh/sshd_config;

# Disable login via password
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config;

# Enable authorized_keys file
echo "# Fix for weird character cannot search replace
AuthorizedKeysFile %h/.ssh/authorized_keys" >> /etc/ssh/sshd_config;

# Disable X11 Forwarding
sed -i "s/X11Forwarding yes/X11Forwarding no/g" /etc/ssh/sshd_config;

# Create Connection Notice
echo "***************************************************************************
                            NOTICE TO USERS

This computer system is the private property of its owner.
It is for authorized use only.  Users (authorized or unauthorized)
have no explicit or implicit expectation of privacy.

Any or all uses of this system and all files on this system may be
intercepted, monitored, recorded, copied, audited, inspected, and
disclosed to your employer, to authorized site, government, and law
enforcement personnel, as well as authorized officials of government
agencies, both domestic and foreign.

By using this system, the user consents to such interception, monitoring,
recording, copying, auditing, inspection, and disclosure at the
discretion of such personnel or officials.  Unauthorized or improper use
of this system may result in civil and criminal penalties and
administrative or disciplinary action, as appropriate. By continuing to
use this system you indicate your awareness of and consent to these terms
and conditions of use. LOG OFF IMMEDIATELY if you do not agree to the
conditions stated in this warning.

***************************************************************************" > /etc/issue.net;

# Enable Connection Notice (uncomment)
sed -i "s/#Banner \/etc\/issue\.net/Banner \/etc\/issue\.net/g" /etc/ssh/sshd_config;

# Disable DNS
echo "USEDNS no" >> /etc/ssh/sshd_config;

# Allow only new user to access server via SSH & SFTP (SFTP accounts SSH to be disabled via /usr/bin/nologin)
echo "AllowUsers $adminuser $sftpuser" >> /etc/ssh/sshd_config;

# Remove distribution-specific extra version suffix from initial protocol handshake
echo "DebianBanner no" >> /etc/ssh/sshd_config;

# Remove annoying prompt about sudo when you login
# http://askubuntu.com/questions/22607/remove-note-about-sudo-that-appears-when-opening-the-terminal
touch /home/$adminuser/.sudo_as_admin_successful;

# Remove the ubuntu legal notice when you login
> /etc/legal;

# Reload SSH
reload ssh;

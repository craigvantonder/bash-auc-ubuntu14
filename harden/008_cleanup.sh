#!/bin/bash

# Fix the admin users home directory permissions
# Make this admin user owner of the extra folders and all other files
chown $adminuser:$adminuser /home/$adminuser/* -R
# Root must own the admin users home dir
chown root:root /home/$adminuser/;
# Set permissions for admin users home dir
chmod 755 /home/$adminuser/;
# Set permissions for admin user’s home dir and all recursive dirs.
find /home/$adminuser -type d -exec chmod 755 {} \;
# Change permissions of all files
find /home/$adminuser -type f -exec chmod 644 {} \;
# Ensure that all new files and folders are created with these rules
chmod g+s /home/$adminuser/;
# .ssh Should be 700 -R
chmod 700 /home/$adminuser/.ssh -R;
# Move the keys directory
mv $installpath/keys/ /home/$adminuser/keys/;
# Move the install log
mv $installpath/install.log /home/$adminuser/install.log;
# Remove the install directory
#rm -rf $installpath/;
# Reboot the server
#reboot;
#!/bin/bash

# Change the root password
echo "root:$rootuserpassword"|chpasswd;

# Give the admin user root privileges by creating a new sudoers include
echo "$adminuser ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$adminuser;

# Give the new sudoers addon the correct permissions
chmod 0440 /etc/sudoers.d/$adminuser;

# Protect SU by limiting access to only the admin groups - Create a group
groupadd admin;

# Add the admin user to the new admin group
usermod -a -G admin $adminuser;

# Create a variable with a random number between 10000 and 11000
randomNumber=$(python -c "import random; print random.randint(10000,11000)");

# Store new entry in the owner and mode settings database that is maintained by dpkg in the override file and set admin ownership to /bin/su
dpkg-statoverride --update --add root admin 4750 /bin/su;
usermod -u $randomNumber $adminuser;
groupmod -g $randomNumber $adminuser;
find / -user 1000 -exec chown -h $randomNumber {} \;
find / -group 1000 -exec chgrp -h $randomNumber {} \;
usermod -g $randomNumber $adminuser;

# Unset the random number
unset randomNumber;

# Change the admin password
echo "$adminuser:$adminuserpassword"|chpasswd;

# Create the .ssh directory for the admin user
mkdir -p /home/$adminuser/.ssh;
# Generate RSA key-pair
ssh-keygen -t rsa -C "$adminuser@$hostname" -f /home/$adminuser/.ssh/id_rsa -N "";
# Authorize the key on the server
cat /home/$adminuser/.ssh/id_rsa.pub >> /home/$adminuser/.ssh/authorized_keys;
# Set correct folder and file permissions
chown $adminuser:$adminuser /home/$adminuser/.ssh/;
chown $adminuser:$adminuser /home/$adminuser/.ssh/*;
chmod 700 /home/$adminuser/.ssh/;
chmod 664 /home/$adminuser/.ssh/*;
# Move the keys to the keys folder
mkdir $installpath/keys/;
mkdir $installpath/keys/$adminuser/;
mv /home/$adminuser/.ssh/id_rsa $installpath/keys/$adminuser/id_rsa;
mv /home/$adminuser/.ssh/id_rsa.pub $installpath/keys/$adminuser/id_rsa.pub;
chmod 644 $installpath/keys/$adminuser/*;
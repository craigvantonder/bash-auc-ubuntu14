#!/bin/bash

PS3='Please choose an option: '
options=("Install Applications" "Harden Server" "Cancel")
select opt in "${options[@]}"
do
    case $opt in
        "Install Applications")
            echo "you chose choice 1"
            ;;
        "Harden Server")
            # Define the absolute path of the repository files
            echo -n "Please enter the absolute path of the auto-configurator: ";
            read installpath;
            export installpath;

            # Define the root users password
            echo -n "Please enter the root users password: ";
            read rootuserpassword;
            export rootuserpassword;

            # Define the admin users name
            echo -n "Please enter the admin users name: ";
            read adminuser;
            export adminuser;

            # Define the admin users password
            echo -n "Please enter the admin users password: ";
            read adminuserpassword;
            export adminuserpassword;

            # Does the server have a static IP?
            echo -n "Does this server have a static IP? (y/n): ";
            read has_static;
            export has_static;

            # Static IP?
            if [ $has_static == "y" ]; then
              # Define the static IP
              echo -n "Please enter the servers IP address: ";
              read ipaddress;
              export ipaddress;

            # Dynamic IP
            else
              # Get the dynamic IP
              ipaddress="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)";
              export ipaddress;
            fi

            # Define the servers hostname
            echo -n "Please enter the servers hostname: ";
            read hostname;
            export hostname;

            # Define the servers domain record
            echo -n "Define the servers domain record: ";
            read domainrecord;
            export domainrecord;

            # Define the servers SSH port
            echo -n "Define the servers SSH port: ";
            read sshport;
            export sshport;

            # Begin Installation
            $installpath/harden/001_start.sh 2> $installpath/install.log;
            ;;
        "Cancel")
            break
            ;;
        *) echo invalid option;;
    esac
done



#!/bin/bash

PS3='Please choose an option: '
options=("Install Applications" "Harden Server" "Cancel")
select opt in "${options[@]}"
do
  case $opt in
    # ============
    # INSTALL APPS
    # ============
    "Install Applications")
      echo "you chose choice 1"
    ;;

    # =============
    # HARDEN SERVER
    # =============
    "Harden Server")
      # Define the absolute path of the repository files
      # /home/admin/bash-auc-ubuntu14 (no trailing slash)
      echo -n "Please enter the absolute path of the auto-configurator: ";
      read installpath;
      export installpath;

      # Define the root users password
      # k2Q10Z8f6desTGTP8ksGZ8Wm
      echo -n "Please enter the root users password: ";
      read rootuserpassword;
      export rootuserpassword;

      # Define the admin users name
      # admin
      echo -n "Please enter the admin users name: ";
      read adminuser;
      export adminuser;

      # Define the admin users password
      # 4TA6DY8297KS0sTix4K2kAJc
      echo -n "Please enter the admin users password: ";
      read adminuserpassword;
      export adminuserpassword;

      # Does the server have a static IP?
      # (none)
      echo -n "Does this server have a static IP? (y/n): ";
      read has_static;
      export has_static;

      # Static IP?
      if [ $has_static == "y" ]; then
        # Define the static IP
        # 10.0.0.1
        echo -n "Please enter the servers IP address: ";
        read ipaddress;
        export ipaddress;

      # Dynamic IP
      else
        # Get the dynamic IP
        # (none)
        ipaddress="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)";
        export ipaddress;
      fi

      # Define the servers hostname
      # github.com
      echo -n "Please enter the servers hostname: ";
      read hostname;
      export hostname;

      # Define the servers domain record
      # github.com
      echo -n "Define the servers domain record: ";
      read domainrecord;
      export domainrecord;

      # Define the servers SSH port
      # 12345
      echo -n "Define the servers SSH port: ";
      read sshport;
      export sshport;

      # Define the servers SSH port
      # Africa/Johannesburg
      echo -n "Define the servers timezone: ";
      read sshport;
      export sshport;

      # Begin Installation
      $installpath/harden/000_start.sh 2> $installpath/install.log;

      # Prompt user that all is done
      echo "Hardening complete, select 1 to Install Applications or 3 to Cancel";
    ;;
    "Cancel")
      break
    ;;
    *) echo invalid option;;
  esac
done



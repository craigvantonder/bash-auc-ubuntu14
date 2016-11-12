#!/bin/bash

echo -n "Database Username: DBUSER > ";
read mysqlappuser;
echo -n "Database Name: database_co_za: > ";
read mysqldatabase;
echo -n "Users Password: 24 STRONG PASS: > ";
read appuserpassword;

echo -n "enter mysql server host address: > ";
read mysqlhost;

mysqlhost=$mysqlhost;

# Create application specific user (use this when connecting in your scripts + generate strong password)
mysql -u onexios -p{} -h $mysqlhost -e "CREATE USER '$mysqlappuser'@'%' IDENTIFIED BY '$appuserpassword';";
# Create a new database to hold the website information
mysql -u onexios -p{} -h $mysqlhost -e "CREATE DATABASE $mysqldatabase;";
# Grant only the privileges used by the app
mysql -u onexios -p{} -h $mysqlhost -e "GRANT ALL PRIVILEGES ON $mysqldatabase . * TO '$mysqlappuser'@'%';";
# Reload Privilege Table
mysql -u onexios -p{} -h $mysqlhost -e "FLUSH PRIVILEGES;";

echo "Created user: $mysqlappuser";
echo "Created Db: ${mysqlappuser}_co_za";

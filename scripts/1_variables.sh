#!/bin/bash

#Variables Declaration 
PACKAGES="wget unzip apache2"
SRV="apache2"
TMPDIR="/tmp/websitefiles"
URL="https://bootstrapmade.com/content/templatefiles/Moderna/Moderna.zip"
SERVICE_NAME="Moderna"
HTMLDIR="/var/www/html/"


# Installing Dependencies
echo "Installing packages"
echo "___________________________________________________"
apt-get update > /dev/null
apt-get install -y $PACKAGES > /dev/null
echo
echo

# Start & Enable Apache Service
echo "Start & Enable Apache Service"
echo "___________________________________________________"
systemctl start $SRV
systemctl enable $SRV
echo
echo

# Main service setup
echo "Service Setup"
echo "___________________________________________________"
mkdir -p $TMPDIR
cd $TMPDIR
wget $URL > /dev/null
unzip $SERVICE_NAME > /dev/null
sudo cp -r $SERVICE_NAME/* $HTMLDIR
echo
echo


# Bounce Service
echo "Restarting Apache service"
echo "___________________________________________________"
systemctl restart $SRV
echo
echo

# Clean Up
echo "Removing Temporary Files"
echo "___________________________________________________"
rm -rf $TMPDIR
echo
echo

# Network Configuration
echo "Network Configuration"
echo "___________________________________________________"
sudo systemctl status $SRV
sudo ip addr show | grep global
echo
echo "Script execution completed."

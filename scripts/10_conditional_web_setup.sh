#!/bin/bash

#Variables Declaration 
#PACKAGES="wget unzip apache2"
#SRV="apache2"
TMPDIR="/tmp/websitefiles"
HTMLDIR="/var/www/html/"
URL="https://bootstrapmade.com/content/templatefiles/Moderna/Moderna.zip"
SERVICE_NAME="Moderna"

#checking OS
echo "Please wait, we are checking your OS type"
sleep 2
apt --help &> /dev/null

# When OS is "Ubuntu"

if [ $? -eq 0 ]
then 
	echo "_________________________________________________________"
	echo "Your OS is Ubuntu, now installation will be started."
	sleep 2
	
# Ubuntu: Variables
	PACKAGES="wget unzip apache2"
	SRV="apache2"

# Ubuntu: Installing packages"
	echo
	echo "_________________________________________________________"
	echo "Required Packages instalations"
	apt-get update > /dev/null
	apt-get install -y $PACKAGES > /dev/null

# Ubuntu: Starting & Enabling Apache Service
	echo
	echo "_________________________________________________________"
	echo "Starting & Enabling Apache Service"
	systemctl start $SRV
	systemctl enable $SRV

# Ubuntu: Main service setup
	echo
	echo "_________________________________________________________"
	echo "/$SERVICE_NAME Service Setup"
	mkdir -p $TMPDIR
	cd $TMPDIR
	wget $URL > /dev/null
	unzip $SERVICE_NAME > /dev/null
	sudo cp -r $SERVICE_NAME/* $HTMLDIR

# Ubuntu: Restarting Apache service
	echo
	echo "_________________________________________________________"
	echo "Restarting Apache service"
	systemctl restart $SRV

# Ubuntu: Clean Up
	echo
	echo "_________________________________________________________"
	echo "Removing Temporary Files"
	rm -rf $TMPDIR

# Ubuntu: Network Configuration
	echo
	echo "_________________________________________________________"
	echo "Network Configuration"
	sudo systemctl status $SRV
	sudo ip addr show | grep global
	echo
	echo "Script execution completed for Ubuntu."

else

echo "_________________________________________________________"
       echo "Your OS is Centos, now installation will be started."
       sleep 2


# Centos: Variables
       PACKAGES="wget unzip httpd"
       SRV="httpd"

# Centos: Installing packages"
       echo
       echo "_________________________________________________________"
       echo "Required Packages instalations"
       yum install -y $PACKAGES > /dev/null

# Centos: Starting & Enabling httpd Service
       echo
       echo "_________________________________________________________"
       echo "Starting & Enabling httpd Service"
       systemctl start $SRV
       systemctl enable $SRV

# Centos: Main service setup
       echo
       echo "_________________________________________________________"
       echo "/$SERVICE_NAME Service Setup"
       mkdir -p $TMPDIR
       cd $TMPDIR
       wget $URL > /dev/null
       unzip $SERVICE_NAME > /dev/null
       sudo cp -r $SERVICE_NAME/* $HTMLDIR

# Centos: Restarting httpd service
       echo
       echo "_________________________________________________________"
       echo "Restarting httpd service"
       systemctl restart $SRV

# Centos: Clean Up
       echo
       echo "_________________________________________________________"
       echo "Removing Temporary Files"
       rm -rf $TMPDIR

# Centos: Network Configuration
       echo
       echo "_________________________________________________________"
       echo "Network Configuration"
       sudo systemctl status $SRV
       sudo ip addr show | grep global
       echo
       echo "Script execution completed for Centos."
fi

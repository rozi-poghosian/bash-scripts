#!/bin/bash

#Variables Declaration 
#------------------------------------------------------------

TMPDIR="/tmp/websitefile"
URL=$1
EXTENSION=$(basename "$1" | awk -F'.' '{print $NF}')
SERVICE_NAME=$(basename "$1" | awk -F'.' '{print $1}')
HTMLDIR="/var/www/html/$SERVICE_NAME"
OSTYPE=$(cat /etc/os-release | head -1 | awk -F'"' '{print $2}')
APACHECONFDEFAULT="/etc/apache2/sites-available/default.conf"
APACHECONFNEW="/etc/apache2/sites-available/$SERVICE_NAME.conf"

# Input checks
wget -q "$1" -P "/tmp"

if [ $? -eq 0 ] && [ "$EXTENSION" = "zip" ]
then

# Checking OS Type
    echo "Please wait, we are checking your OS type"
    sleep 2
    echo "your OS Type is $OSTYPE"
    if [ "$OSTYPE" = "Ubuntu" ]
    then
	PACKAGES=(wget unzip apache2)
        SRV="apache2"
        PACKAGEMANAGER="apt-get"
    elif [ "$OSTYPE" = "Centos" ]
    then
	PACKAGES=(wget unzip httpd)
        SRV="httpd"
        PACKAGEMANAGER="yum"
    else 
        echo "Your OS is not Ubunto os Centos, please try one of them!" 
    fi


# Installing packages
    echo
    echo "_________________________________________________________"
    echo "Required Packages instalations"
    $PACKAGEMANAGER update -y > /dev/null
    for package in "${PACKAGES[@]}" 
    do
        $PACKAGEMANAGER install -y $package > /dev/null
    done

# Starting & Enabling Apache Service
    echo
    echo "_________________________________________________________"
    echo "Starting & Enabling $SRV Service"
    systemctl enable --now $SRV

# Main service setup
    echo
    echo "_________________________________________________________"
    echo "ALIAS Setup"
    mkdir $HTMLDIR
    cp -r $APACHECONFDEFAULT $APACHECONFNEW
    sed -i "s|DocumentRoot /var/www/html/|DocumentRoot /var/www/html/$SERVICE_NAME|g" $APACHECONFNEW
    
    echo "_________________________________________________________"
    echo "$SERVICE_NAME Service Setup"
    #mkdir $HTMLDIR
    cd $TMPDIR
    wget $URL > /dev/null
    unzip $SERVICE_NAME > /dev/null
    cp -r $SERVICE_NAME/* $HTMLDIR

# Restarting Apache service
    echo
    echo "_________________________________________________________"
    echo "Reloading $SRV service"
    systemctl reload $SRV

# Clean Up
    echo
    echo "_________________________________________________________"
    echo "Removing Temporary Files"
    rm -rf $TMPDIR

# Network Configuration
    echo
    echo "_________________________________________________________"
    echo "Network Configuration"
    systemctl status $SRV
    ip addr show | grep global
    echo "_________________________________________________________"
    echo
    echo "Script execution completed for Ubuntu."

else
    echo "Something went wrong! Please follow  the guid:"
    echo "______________________________________________________________________________________________"
    echo "1st argument should be the URL to download .zip file"
    echo "EX: https://bootstrapmade.com/content/templatefiles/HeroBiz/HeroBiz.zip"
    echo
    echo "2nd argument should be 'website1' or 'website2' for the Alias"
    echo "EX: website1"

fi

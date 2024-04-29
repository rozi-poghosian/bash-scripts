#!/bin/bash

# Variables 
FREERAM=$(free -m | grep Mem | awk '{print $4}')
LOAD=`uptime | awk '{print $10 $11 $12}'`
ROOTFREE=$(df -h | grep /dev/sda3 | awk '{print $4}')


# Welcome Message
echo "welcome $USER on our contabo VPS named $HOSTNAME"
echo


# General info
echo "____________________________________________________________________________"
echo 
echo "Available free RAM is $FREERAM MB, that is calulated by \$FREERAM"
echo 
echo "____________________________________________________________________________"
echo
echo "Current Load Average is $LOAD, that is calulated by \$LOAD"
echo 
echo "____________________________________________________________________________"
echo
echo "Free ROOT partiotion size is $ROOTFREE, that is calulated by \$ROOTFREE"
echo 
echo "____________________________________________________________________________"


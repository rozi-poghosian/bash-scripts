#!/bin/bash

DATE=$(date)

echo
echo "Now is $DATE"
ls /var/run/apache2/apache2.pid &>> /dev/null

if [ $? -eq 0 ]
then
    echo "___________________________________________"
    echo "apache2 process is running!"
else
    echo "___________________________________________"
    echo "apache2 process is NOT running"
    echo "Please wait we will start the process"
    sleep 3
    systemctl start apache2.service
    ls /var/run/apache2/apache2.pid &>> /dev/null
    if [ $? -eq 0 ]
    then
        echo 
        echo "Now apache2 process is running"
    else
        echo "Process Starting Failed, contact the admin"
    fi
fi

#!/bin/bash

USERS="$1 $2 $3"
RESULT=$(cat /etc/passwd | grep /bin/sh | awk -F: '{print $1}')

for usr in $USERS
do
    echo Wait, we are adding $usr
    useradd $usr
    sleep 2
    id $usr
    echo "_____________________________"
    echo

done

echo "________________________________"
echo "Here are the users you tell me to add"
echo $RESULT

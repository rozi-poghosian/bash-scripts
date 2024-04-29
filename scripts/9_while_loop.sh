#!/bin/bash

COUNTER=1

while [ $COUNTER -lt 6 ]
do
    echo "________________________________"
    echo
    echo "Now I'm IN the loop"
    echo "Your counter value is $COUNTER"
    COUNTER=$(( $COUNTER + 1 ))
    sleep 1
    echo
done

echo
echo "Now I'm OUT of the loop"

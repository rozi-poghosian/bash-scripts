#!/bin/bash
#echo "the result of 0 is $0"

#echo "the result of # is $#"

#echo "the result of 1 is $1"

#echo "the result of 2 is $2"

#echo "the result of @ is $@"

#echo "the result of ? is $?"

#echo "the result of $ is $$"

#echo "the result of LINENO is $LINENO"

#echo "the result of SECONDS is $SECONDS"


#!/bin/bash
#echo "Bash version ${BASH_VERSION}"
#for i in {0..10..2}
#     echo "Welcome $i times"
# done


#!/bin/bash

#counter=2

#while true
#do
#  echo "Looping...."
#  echo "Value of counter is $counter."
#  counter=$(( $counter * 2 ))
#  sleep 1
#done

#echo "Out of the loop"

#!/bin/bash

# Initialize sum
#sum=0

# Loop through each number and add it to the sum
#for num in "$@"; do
#    sum=$((sum + num))
#done

# Print the sum
#echo "Sum: $sum" 

# Input checks

EXTENSION=$(basename "$1" | awk -F'.' '{print $NF}')
FILENAME=$(basename "$1" | awk -F'.' '{print $1}')
wget -q "$1" -P "/tmp"


if [ $? -eq 0 ] && [ "$EXTENSION" = "zip" ] && [ "$FILENAME" = "$2" ]
then
	echo "ok"

else 
	echo "Something went wrong! Please follow  the guid:"
	echo "______________________________________________________________________________________________"
        echo "1st argument should be the URL to download .zip file"
        echo "EX: https://bootstrapmade.com/content/templatefiles/HeroBiz/HeroBiz.zip"
       	echo
	echo "2nd argument is the zip file name, that shoulb be the same as written at the end of URL"
        echo "EX: HeroBiz"

fi





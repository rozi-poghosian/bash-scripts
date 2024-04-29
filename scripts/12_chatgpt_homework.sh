#The problem statement
# 1.Prompts the user to enter a directory path.
# 2.Validates if the entered directory exists.
# 3.If the directory exists, proceed with the following steps:
#   --Lists all the files in the directory.
#   --Counts the number of files in the directory.
#   --Displays the total size of all files in the directory.
#   --Finds and displays the largest file in the directory.
#   --Sorts the files in the directory based on their sizes (ascending or descending, as per user's choice).
#   --Provides an option to create a backup of the directory (copy all files to a backup directory).


# 1.Prompts the user to enter a directory path
# __________________________________________________
BACKUPFILE="/root/backupfile"

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
read -p "Enter your directory path: " DIRPATH

# 2.Validates if the entered directory exists.
# __________________________________________________

echo "Please wait we are checking the path"
sleep 2
echo
CONDITION=$(file "$DIRPATH" | awk '{print $2}')
#cat $DIRPATH &> /dev/null

if [ "$CONDITION" = "directory" ]
then
	echo "Congratulations! Your directory exists.Here are it's files"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# 3.1. Lists all the files in the directory.
# __________________________________________

	ls $DIRPATH

# 3.2. Counts the number of files in the directory.
# __________________________________________________

	COUNT=$(ls -l $DIRPATH | wc -l)
	echo

# 3.3. Displays the total size of all files in the directory.
# ___________________________________________________________

	TOTAL=$( ls -lh $DIRPATH | grep total | awk '{print $2}' )

	echo "You have totaly $COUNT files which total size is $TOTAL"
	echo


# 3.4. Finds and displays the largest file in the directory.
# ___________________________________________________________

	LARG_FILE_SIZE=$( ls -lS $DIRPATH | head -2 | awk '{print $5}' )
	LARG_FILE_NAME=$(  ls -lS $DIRPATH | head -2 | awk '{print $9}' )

 	echo "The largist file is $LARG_FILE_NAME and its size is $LARG_FILE_SIZE"
	echo



# 3.5. Sorts the files in the directory based on their sizes (ascending or descending, as per user's choice).
# ____________________________________________________________________________________________________________

	read -p "Tell me how you want to sort your directory ascending (type 1) or descending (type 2): " SORTING
		if [ $SORTING -eq 1 ]
		then
			ls -ls $DIRPATH
		elif [ $SORTING -eq 2 ]
		then
			ls -rls $DIRPATH
		else
			echo "Oops! I tell you to type 1 or 2. Good Bye!"
		fi
	echo


# 3.4. Provides an option to create a backup of the directory (copy all files to a backup directory).
# ____________________________________________________________________________________________________

	read -p "Do you want to backup your files (YES/NO): " BACKUP
		if [ "$BACKUP" = "YES" ]
		then
			sleep 2
			echo 
			cp -r $DIRPATH $BACKUPFILE
			echo "Here is your backupfile path: $BACKUPFILE"
			read -p "Do you want to se the content (YES/NO):" CONTENT
				if [ "$CONTENT" = "YES" ]
                		then 
					ls -l $BACKUPFILE
					echo "Welcome, GoodBye!"
				elif [ "$CONTENT" = "NO" ]
                                then 
					echo "OK, Goodbye!"
				else 
					echo "Oops! I tell you to type YES or NO. GoodBye!"
				fi	

		elif [ "$BACKUP" = "NO" ]
		then
			sleep 2
			echo
			echo "Thank You, we will not backup you file. GoodBye!"

		else
			echo "Oops! I tell you to type YES or NO. GoodBye!"
		fi
	


else
	echo "Oops! We connot find your Directory, please try again. GoodBye!"

fi


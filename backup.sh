#!/bin/bash

# Create backup of files by making archives

#Disabling case-sensitivity for comparison / Enable nocasematch option
shopt -s nocasematch

# Creating a backup path
backup_path="$HOME/backup"

# Check if backup path exists ot not
if [[ ! -d "$backup_path" ]]; then
	mkdir "$HOME/backup"
fi

#The tar file function
tar_() {
	read -p "Do you wanna compress it or not ?" choice

	if [[ "$choice" == "yes" ]]; then
		compression_ $1
	elif [[ "$choice" == "no" ]]; then
		tar -cvf "$backup_path/backup.tar" "$1"
	else
		echo "Please say yes or no dum!!"
		exit

	fi
}

# Compression method
compression_() {
	echo "So you wanna compress the archive huh ..."
	echo "
	Do you wanna make it --> 
	1. gzip
	2. bzip2

	Please respond with proper number
	"
	read method

	if [[ "$method" -eq 1 ]]; then
		tar -czvf "$backup_path/backup.tar.gz" "$1"
	elif [[ "$method" -eq 2 ]]; then
		tar -cjvf "$backup_path/backup.tar.bz2" "$1"
	else
		echo "I told you please enter a valid input"
		exit
	fi
}

#The zip file function
zip_() {
	echo "Do you wanna add passwords or not ?"
	read option

	if [[ "$option" == "yes" ]]; then
		zip -e "$backup_path/backup.zip" "$1"
	elif [[ "$option" == "no" ]]; then
		zip "$backup_path/backup.zip" "$1"
	else
		echo "Fuck off!!"
		exit
	fi
}



# Taking the inputs from the user
echo "Write the path to the files/dirs for which you wanna create a backup ?"
read -r path

# checking if path is valid or not
if [[ ! -f "$path" ]]; then
	if [[ ! -d "$path" ]]; then
		echo "Invalid path nothing is there"
		echo "Creating the file..."
		touch "$path"

	else 
		echo "Got the dir"
	fi
else  
	echo "Got the file"
fi

# Taking the backup form input from the user
echo "
You can find your archives in ~/backup dir.

In which form do you wanna create the backup -->
1. Tar file
2. Zip file

Press the respective number to continue.
eg --> Press 1 for tar

"
read option

# Checking the valid option
case "$option" in
	1) echo "Staring the process using Tar"
		;;
	2) echo "Staring the process using Zip"
		;;
	*) echo "Plase insert a valid option"
	   exit
		;;
esac

if [[ option -eq 1 ]]; then
	tar_ $path
elif [[ option -eq 2 ]]; then
	zip_ $path
fi

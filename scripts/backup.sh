#!/bin/bash

# Script to backup a folder from source provided to destination provided/ All files are zip
# Read the source folder and destination folder from the command line. Source as the first 
# while destination as the second variables
if [ $1 ]; then 
    source=$1
else
    read -p 'Please enter the source folder name to backup:>> ' source 
fi 

if [ $2 ]; then 
    dest=$2
else 
    read -p 'Please enter the destination folder directory you want your backup to go :>> ' dest 

fi 

# check if file exist
function fileExxists(){
    if [ -f $dest/backup.tar.gz ]; then 
        echo 'this file already exist' 
        exit 1
    fi 
}

#compressed and backup
function compressed(){

# package the source folder in .tar
tar -cvf backup.tar $source 

# zip the folder using gzip
gzip backup.tar 

# move to destination 
mv backup.tar.gz $dest 

}

# call the functions
fileExxists
compressed



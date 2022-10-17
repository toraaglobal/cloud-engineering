#!/bin/bash

# Move all zip file to data_file
for file in $(find . -name *.zip)
do 
   mv $file data_file/
done 
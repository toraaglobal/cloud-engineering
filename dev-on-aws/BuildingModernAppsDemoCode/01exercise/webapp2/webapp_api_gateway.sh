#!/bin/bash

# Get bucket name from user
echo "Please enter a bucket name: "; read bucket;  export MYBUCKET=$bucket

# create the bucket 
if [[ $(aws s3 mb s3://$MYBUCKET) ]]; then
    # set environment variables 
    echo "export MYBUCKET=$MYBUCKET" >> ~/.bashrc

    # list bucket contents
    aws s3 ls 

else 
    echo bucket name much be unique. try another name
    exit 1
fi 


# download and extract the web application.
# After the API gateway is develop and deployed

curl  https://aws-tc-largeobjects.s3.amazonaws.com/DEV-AWS-MO-BuildingRedux/downloads/webapp2.zip -o $(pwd)/webapp2.zip
unzip $(pwd)/webapp2.zip -d $(pwd)/webapp2

# Copy all the contents of the webapp2 folder to Amazon Simple Storage Service (Amazon S3).
aws s3 cp $(pwd)/webapp2 s3://$MYBUCKET/dragonsapp/ --recursive --acl public-read

echo "URL: https://$MYBUCKET.s3.amazonaws.com/dragonsapp/index.html"

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



# # Download and extract the web application
# if [[ $(curl https://aws-tc-largeobjects.s3.amazonaws.com/DEV-AWS-MO-BuildingRedux/downloads/webapp1.zip -o $(pwd)/webapp1.zip) ]]; then 

#    echo webapp downloaded successfully 
# else 
#     echo Unable to download the web application. using the wget command
#     exit 2
# fi 

curl https://aws-tc-largeobjects.s3.amazonaws.com/DEV-AWS-MO-BuildingRedux/downloads/webapp1.zip -o $(pwd)/webapp1.zip

unzip $(pwd)/webapp1.zip -d $(pwd)/webapp1

# Copy all the contents of the webapp1 folder to Amazon S3.
aws s3 cp $(pwd)/webapp1 s3://$MYBUCKET/dragonsapp/ --recursive --acl public-read


# get the url for the application
echo Access the web application using the URL link below 
echo "URL: https://$MYBUCKET.s3.amazonaws.com/dragonsapp/index.html"


# Setting up the Dragons application
# Download the source of the dragons data: dragon_stats_one.txt
# if [[ $(curl https://aws-tc-largeobjects.s3.amazonaws.com/DEV-AWS-MO-BuildingRedux/downloads/dragon_stats_one.txt -o $(pwd)/dragon_stats_one.txt) ]]; then
#     # copy it to s3 bucket 
#     aws s3 cp $(pwd)/dragon_stats_one.txt s3://$MYBUCKET

#     aws s3 ls s3://$MYBUCKET
# else 
#     echo Unable to download the dragon data to set up the application using wget 
#     exit 3
# fi 

curl https://aws-tc-largeobjects.s3.amazonaws.com/DEV-AWS-MO-BuildingRedux/downloads/dragon_stats_one.txt -o $(pwd)/dragon_stats_one.txt
aws s3 cp $(pwd)/dragon_stats_one.txt s3://$MYBUCKET

aws s3 ls s3://$MYBUCKET


# Set the Parameter Store value for dragon_data_bucket_name
aws ssm put-parameter \
--name "dragon_data_bucket_name" \
--type "String" \
--overwrite \
--value $MYBUCKET


# Set the Parameter Store value for the dragon_data_file_name
aws ssm put-parameter \
--name "dragon_data_file_name" \
--type "String" \
--overwrite \
--value dragon_stats_one.txt


# Exploring the console application
# Download and extract the console application, which is a Python file.
# if [[ $(curl https://aws-tc-largeobjects.s3.amazonaws.com/DEV-AWS-MO-BuildingRedux/downloads/app.py -o $(pwd)/app.py) ]]; then 
#     python $(pwd)/app.py
# else 
#     echo Unbale to download the console application 
#     exit 4 

curl https://aws-tc-largeobjects.s3.amazonaws.com/DEV-AWS-MO-BuildingRedux/downloads/app.py -o $(pwd)/app.py
python $(pwd)/app.py







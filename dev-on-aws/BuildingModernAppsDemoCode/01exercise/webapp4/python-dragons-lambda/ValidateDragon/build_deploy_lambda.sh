#!/bin/bash

# Query IAM role and set environment variables
export ROLE_ARN_READWRITE=`aws iam get-role --role-name dragons-readwrite-lambda-role  --query 'Role.Arn' --output text`
export ROLE_ARN_READ=`aws iam get-role --role-name dragons-read-lambda-role  --query 'Role.Arn' --output text`


#Inspect the environment variables.
echo $ROLE_ARN_READ $ROLE_ARN_READWRITE

# install boto3 as target directory
pip install -t package boto3

# packega zip
cd /package
zip -r ../pythonvalidateDragonFunction.zip . 

# Add the listDragons.py file to the .zip file.
zip -g pythonvalidateDragonFunction.zip validateDragon.py


# create function
aws lambda create-function --function-name ValidateDragon \
--runtime python3.9  \
--role $ROLE_ARN_READ \
--handler validateDragon.validate \
--publish \
--zip-file fileb://pythonvalidateDragonFunction.zip



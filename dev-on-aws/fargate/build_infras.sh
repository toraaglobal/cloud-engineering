#!/bin/bash

# Build basic infrastructure to support fargate application deployment in AWS
# This will create two vpc. one for admin/central and the other for application deployment
# It will also create the iam role to support fargate application deployment 
# the admin and work vpc are peered

echo Building the Admin VPC 

workingFolder=$(pwd)
cd $workingFolder/infrastructure/vpc/admin 
ls -la 
stackility upsert -i config.ini 


echo Building Application vpc
cd $workingFolder/infrastructure/vpc/work 
ls -la 
stackility upsert -i config.ini 



echo Building IAM roles 
cd $workingFolder/infrastructure/iam 
ls -la 
stackility upsert -i config.ini 










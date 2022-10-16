#!/bin/bash

# deploy fargate application 
# Using the infrastructure created for application deployment 


echo Deploying application infargate 

workingFolder=$(pwd)

# change working directory
cd $workingFolder/fargate_apps_demo/
ls -la 

# build the cloud formation template 
stackility upsert -i config.ini 
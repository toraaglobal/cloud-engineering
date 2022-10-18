#!/bin/bash 

# find the aws lambda ARN
aws lambda list-functions --query 'Functions[].FunctionArn'
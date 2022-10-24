LAB 1
Download the Lab

curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-create/lab1.zip -o lab1.zip



node create_table.js

LAB 2
After completing this exercise, you will be able to use the AWS SDKs to do the following:
Upload items to the DynamoDB table.
Query your DynamoDB table using code (i.e a full table scan).
Create a role for an AWS Lambda function using AWS Identity and Access Management (IAM).
Create an AWS Lambda function that talks to DynamoDB, using the Lambda console.
Create an CORS enabled Amazon API Gateway that p

curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-update/lab2.zip -o lab2.zip


node upload_items.js


 Upload the website to S3
 pushd ./resources && node upload_website.js && popd


 echo "URL: https://dragonstoraaglobal.s3.amazonaws.com/index.html"


 Bucket Policy
 ```
{
 "Version": "2008-10-17",
 "Statement": [
 {
 "Effect": "Allow",
 "Principal": "*",
 "Action": "s3:GetObject",
 "Resource": "arn:aws:s3:::yourwebsite/*",
 "Condition": {
 "IpAddress": {
 "aws:SourceIp": [
 "98.41.14.7/32"
 ]
 }
 }
 }
 ]
}
 ```



 LAB 3

 curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-seed/lab3.zip -o lab3.zip



LAB 4
curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-monitor/lab4.zip -o lab4.zip


LAB 5
curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-members/lab5.zip -o lab5.zip



curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-secure/lab6.zip -o lab6.zip


curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-admin/lab7.zip -o lab7.zip


curl https://s3.amazonaws.com/awsu-hosting/edx_dynamo/c9/dynamo-single/lab8.zip -o lab8.zip
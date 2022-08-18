# Veryfy AWS credentials your IDE using
aws sts get-caller-identity


# CLIO command to delete amazon bucket 
bucketToDelete=$(aws s3api list-buckets --output text --query 'Buckets[?contains(Name, `deletemebucket`) == `true`] | [0].Name')
aws s3 rb s3://$bucketToDelete
## Delete with debug 
aws s3 rb s3://$bucketToDelete --debug


# Review a customer managed IAM policy
policyArn=$(aws iam list-policies --output text --query 'Policies[?PolicyName == `S3-Delete-Bucket-Policy`].Arn')
aws iam get-policy-version --policy-arn $policyArn --version-id v1



# Create a variable that contains the bucket name
mybucket=$(aws s3api list-buckets --output text --query 'Buckets[?contains(Name, `notes-bucket`) == `true`].Name')


# sync file from the html folder to bucket
aws s3 sync ~/environment/labRepo/html/. s3://$mybucket/


# Run the following command to update the bucket name placeholder in the policy.json
sed -i "s/\[BUCKET\]/$mybucket/g" ~/environment/labRepo/policy.json 


# verify the updated file
cat ~/environment/labRepo/policy.json


# set the region to a variable
region=$(curl http://169.254.169.254/latest/meta-data/placement/region -s)



printf "\nYou can now access the website at:\nhttp://$mybucket.s3-website.$region.amazonaws.com\n\n"



cd ~/environment/api/

# add disksize
bash resize.sh 15

# create a bucket variable for the deployment
apiBucket=$(aws s3api list-buckets --output text --query 'Buckets[?contains(Name, `pollynotesapi`) == `true`].Name')


# Build the application 
sam build --use-container


# deploy the application
sam deploy --stack-name polly-notes-api --s3-bucket $apiBucket --parameter-overrides apiBucket=$apiBucket

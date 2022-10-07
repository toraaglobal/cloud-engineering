# create variables
apiURL=https://lcbfxe7jtc.execute-api.us-west-2.amazonaws.com/Prod

CognitoPoolId='us-east-1_p4huhZR9l'

AppClientId='2bo1fke1u94s4nqmdgvtbf21mf'


# create a new amazon cognito username 
aws cognito-idp sign-up --client-id $AppClientId --username student --password student


# confirm the user created 
aws cognito-idp admin-confirm-sign-up --user-pool-id $CognitoPoolId --username student





# customize the saggwer file by replacing the place holders in it 
region=$(curl http://169.254.169.254/latest/meta-data/placement/region -s)

acct=$(aws sts get-caller-identity --output text --query "Account")

poolId=$(aws cognito-idp list-user-pools --max-results 1 --output text --query "UserPools[].Id")

poolArn="arn:aws:cognito-idp:$region:$acct:userpool/$poolId"



sed -i "s~\[Cognito_Pool_ARN\]~$poolArn~g" ~/environment/api/PollyNotesAPI-swagger.yaml

sed -i "s~\[AWS_Region\]~$region~g" ~/environment/api/PollyNotesAPI-swagger.yaml

sed -i "s~\[AWS_AccountId\]~$acct~g" ~/environment/api/PollyNotesAPI-swagger.yaml



# merge the swagger file to an existing API
cd ~/environment/api

apiId=$(aws apigateway get-rest-apis --query "items[?name == 'PollyNotesAPI'].id" --output text)

# import the new resource to API Gateway
aws apigateway put-rest-api --rest-api-id $apiId --mode merge --body 'fileb://PollyNotesAPI-swagger.yaml'

# deploy the resource 
aws apigateway create-deployment --rest-api-id $apiId --stage-name Prod


# Add lambda permission to the function
aws lambda add-permission --function-name delete-function --statement-id apiInvoke --action lambda:InvokeFunction --principal apigateway.amazonaws.com

aws lambda add-permission --function-name dictate-function --statement-id apiInvoke --action lambda:InvokeFunction --principal apigateway.amazonaws.com

aws lambda add-permission --function-name search-function --statement-id apiInvoke --action lambda:InvokeFunction --principal apigateway.amazonaws.com



# update the config.js file place holders

sed -i "s~\[UserPoolId\]~$CognitoPoolId~g" ~/environment/web/src/Config.js

sed -i "s~\[AppClientId\]~$AppClientId~g" ~/environment/web/src/Config.js

sed -i "s~\[ApiURL\]~$apiURL~g" ~/environment/web/src/Config.js



# install dependencies 
cd ~/environment/web
npm install

# build the project 
npm run test+build


# create a variable that contain your website
webBucket=$(aws s3api list-buckets --output text --query 'Buckets[?contains(Name, `pollynotesweb`) == `true`].Name')


# copy the files to S3 for hosting 
aws s3 sync --delete build/. s3://$webBucket


Video Intelligence
***

**Steps**

- list active accout `gcloud auth list`
- list project ID `gcloud config list project`
- Enable the Video Intelligence API
- Set up authorization
    - create a new service account named quickstart:
    ```
    gcloud iam service-accounts create quickstart
    ```
    - Create a service account key file, replacing <your-project-123> with your Qwiklabs Project ID
    ```
    gcloud iam service-accounts keys create key.json --iam-account quickstart@<your-project-123>.iam.gserviceaccount.com
    ```
    - Now authenticate your service account, passing the location of your service account key file
    ```
    gcloud auth activate-service-account --key-file key.json
    ```
    - Obtain an authorization token using your service account
    ```
    gcloud auth print-access-token
    ```

- Make an annotate video request
    - Run this command to create a JSON request file with the following text, and save it as request.json 
    ```
    cat > request.json <<EOF
    {
    "inputUri":"gs://spls/gsp154/video/train.mp4",
    "features": [
        "LABEL_DETECTION"
    ]
    }
    EOF
    ```
    - Use curl to make a videos:annotate request passing the filename of the entity request
    ```
    curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/videos:annotate' \
    -d @request.json

    ```

    - You should now see a response that includes your operation name, which should look similar to this one:
    ```
    {
    "name": "projects/474887704060/locations/asia-east1/operations/16366331060670521152"
    }

    ```
    - Use this script to request information on the operation by calling the v1.operations endpoint. Replace the PROJECTS, LOCATIONS and OPERATION_NAME with the value you just received in the previous command

    ```
    curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/projects/PROJECTS/locations/LOCATIONS/operations/OPERATION_NAME'

    ```
Cloud Natural Language API
***

**Steps**

- list active project `gcloud auth list`
- list project ID `gcloud config list project`
- Create an API Key
    - Set environment variable with the project_id 
    ```
    export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)
    ```
    - create a new service account to access the Natural Language API
    ```
    gcloud iam service-accounts create my-natlang-sa --display-name "my natural language service account"
    ```
    - create credentials to log in as your new service account. Create these credentials and save it as a JSON file "~/key.json" by using the following command
    ```
    gcloud iam service-accounts keys create ~/key.json \
  --iam-account my-natlang-sa@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com
    ```
    - set the GOOGLE_APPLICATION_CREDENTIALS environment variable
    ```
    export GOOGLE_APPLICATION_CREDENTIALS="/home/USER/key.json"
    ```

- Make an Entity Analysis Request
```
gcloud ml language analyze-entities --content="Michelangelo Caravaggio, Italian painter, is known for 'The Calling of Saint Matthew'." > result.json
```

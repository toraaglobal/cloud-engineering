
Google Cloud Speech API
***
**Steps**

- list active accout `gcloud auth list`
- list project ID `gcloud config list project`
- Create an API Key
- export API key `export API_KEY=<YOUR_API_KEY>`
- Create your Speech API request
    - touch request.json
    - nano request.json
    - Add the following to your request.json file, using the uri value of the sample raw audio file
    ```
    {
    "config": {
        "encoding":"FLAC",
        "languageCode": "en-US"
    },
    "audio": {
        "uri":"gs://cloud-samples-tests/speech/brooklyn.flac"
    }
    }
    ```

- Call the Speech API
```
curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}"

```

- Run the following command to save the response in a result.json file:
```
curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json
```

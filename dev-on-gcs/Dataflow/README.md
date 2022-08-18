Dataflow
***

**Steps**

- activate account  `gcloud auth list`
- list project id `gcloud config list project`
- create a cloud sotorage bucket
- Install pip and the Cloud Dataflow SDK

```
docker run -it -e DEVSHELL_PROJECT_ID=$DEVSHELL_PROJECT_ID python:3.7 /bin/bash
```

- intall apache-beam `pip install apache-beam[gcp]`

- Run the wordcount.py example locally by running the following command
```
python -m apache_beam.examples.wordcount --output OUTPUT_FILE
```
- Run an Example Pipeline Remotely

```
# set the bucket path
BUCKET=gs://<bucket name provided earlier>

# run the job remotely
python -m apache_beam.examples.wordcount --project $DEVSHELL_PROJECT_ID \
  --runner DataflowRunner \
  --staging_location $BUCKET/staging \
  --temp_location $BUCKET/temp \
  --output $BUCKET/results/output \
  --region us-central1
```
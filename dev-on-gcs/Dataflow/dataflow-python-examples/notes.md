ETL Processing on Google Cloud Using Dataflow and BigQuery

- Download starter code
    gsutil -m cp -R gs://spls/gsp290/dataflow-python-examples .

- Set project
    export PROJECT=''
    gcloud config set project $PROJECT

- Create Cloud Storage Bucket
    gsutil mb -c regional -l   gs://$PROJECT


- Copy Files to Your Bucket
    gsutil cp gs://spls/gsp290/data_files/usa_names.csv gs://$PROJECT/data_files/
    gsutil cp gs://spls/gsp290/data_files/head_usa_names.csv gs://$PROJECT/data_files/ 


- Create the BigQuery Dataset
    bq mk lake


- Run the Apache Beam Pipeline
    The Dataflow job in this lab requires Python3.7. To ensure you're on the proper version, you will run the process on a Python 3.7 Docker container.

    docker run -it -e PROJECT=$PROJECT -v $(pwd)/dataflow-python-examples:/dataflow python:3.7 /bin/bash


- Once the container finishes pulling, run the following to install apache-beam:
    pip install apache-beam[gcp]==2.24.0

- change directories into where you linked the source code:
    cd dataflow/


- You will run the Dataflow pipeline in the cloud.The following will spin up the workers required, and shut them down when complete:

    python dataflow_python_examples/data_ingestion.py \
                --project=$PROJECT --region=us-east5 \
                --runner=DataflowRunner \
                --staging_location=gs://$PROJECT/test \
                --temp_location gs://$PROJECT/test \
                --input gs://$PROJECT/data_files/head_usa_names.csv \
                --save_main_session




    python dataflow_python_examples/data_transformation.py \
                --project=$PROJECT \
                --region=us-east5 \
                --runner=DataflowRunner \
                --staging_location=gs://$PROJECT/test \
                --temp_location gs://$PROJECT/test \
                --input gs://$PROJECT/data_files/head_usa_names.csv \
                --save_main_session



    python dataflow_python_examples/data_enrichment.py \
                --project=$PROJECT \
                --region=us-east5 \
                --runner=DataflowRunner \
                --staging_location=gs://$PROJECT/test \
                --temp_location gs://$PROJECT/test \
                --input gs://$PROJECT/data_files/head_usa_names.csv \
                --save_main_session



- Data lake to Mart
     python dataflow_python_examples/data_lake_to_mart.py \
                --worker_disk_type="compute.googleapis.com/projects//zones//diskTypes/pd-ssd" \
                --max_num_workers=4 \
                --project=$PROJECT \
                --runner=DataflowRunner \
                --staging_location=gs://$PROJECT/test \
                --temp_location gs://$PROJECT/test \
                --save_main_session \
                --region=us-east5
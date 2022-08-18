Dataproc
*** 

**Steps**

- list active account `gcloud auth list`
- list project id `gcloud config list project`
- check permission `{project-number}-compute@developer.gserviceaccount.com` to editor
- Create a cluster
    - set the region `gcloud config set dataproc/region us-central1`
    - create a cluster called example-cluster 
        ```
        gcloud dataproc clusters create example-cluster --worker-boot-disk-size 500
        ```
- submit a job
```
gcloud dataproc jobs submit spark --cluster example-cluster \
  --class org.apache.spark.examples.SparkPi \
  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000
```

- Update a cluster
    - To change the number of workers in the cluster to four
        ```
        gcloud dataproc clusters update example-cluster --num-workers 4
        ```
    - You can use the same command to decrease the number of worker nodes
        ```
        gcloud dataproc clusters update example-cluster --num-workers 2
        ```
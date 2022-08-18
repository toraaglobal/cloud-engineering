Building an IoT Pipeline on Google Cloud
***
**Overview**

The term IoT means the interconnection of physical device to the global internet.
Cloud IoT Core is a fully managed service that allow you to easily and securely connect, manage, and ingest data from millions of globally disperse devices. Its uses the MQTT protocol to other Google Cloud data service.

Cloud IoT Core has two main conponents
- A device manager for registering devices with the service, so you can monitor and configure them.
- A protocol bridge that support MQQT, which devices can use to connect to google cloud.

**Steps**
- Enable APIs: Ensure the following APIs are enables
    - Google Cloud IoT API
    - Cloud Pub/Sub API
    - Dataflow API

- Create a cloud Pub/Sub Topic
- Create a BiqQuery dataset to ingest the data 
    - create table
- Create a cloud storage bucket for Dataflow pipeline
- Set up Dataflow pipeline




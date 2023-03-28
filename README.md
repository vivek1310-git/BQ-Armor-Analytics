# BQ-Armor-Analytics
This is repo for creating Dashboard of Armor Log data Analytics using BigQuery and Data Studio

## Why use the Google Cloud Armor Visibility Dashboard?

The Cloud Armor Visibility Dashboard? allows you to view and analyze  Google Global Load-Balancing security data related to Web Application Security (WAF), from Google Cloud Armor. The Visibility Dashboard gives you the ability to integrate security, traffic and web application metrics, to perform security monitoring and analysis of your Google Cloud resources protected by Cloud Armor. This gives location based insight about the traffic and lets you drill down to the final level of data.


## Getting Started

### Requirements
* Bigquery dataset exists
* Log data integrated with Bigquery Dataset
* Access to create tables/View in this Bigquery Dataset
* Data viewer access on this Bigquery Dataset


## Technical installation

### 1) Setup the Environment variables

    export USER_EMAIL=<email_id>
    export PROJECT_ID=<Project_id>
    export DATASET=<dataset name>
    export REGION=<region>


### 2) Execute the schema_setup.sh

      sh ./schema_setup.sh
     
### 3) Setup Looker Studio Dashboard for your dataset

#### a) Copy [this](https://lookerstudio.google.com/c/u/0/reporting/794371be-a32c-4623-a388-9aa96b0c5e6a/page/04pID) Looker Dashboard to your Looker studio account (Check the image below)
<img width="537" alt="Screenshot 2023-03-24 at 1 23 42 PM" src="https://user-images.githubusercontent.com/126858124/227850027-c5d7d51a-78d6-45f0-aab3-6255f2e592d8.png">


#### b) On New data source dropdown, select "create Data source"



<img width="727" alt="Screenshot 2023-03-27 at 11 09 12 AM" src="https://user-images.githubusercontent.com/126858124/227850522-603cd402-d311-460f-b9da-f7197a946405.png">

#### c) Select Bigquery connector and then select your project, Dataset and log_report table and then click on connect.







#### Start analyzing your data !!!

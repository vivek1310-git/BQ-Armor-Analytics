# BQ-Armor-Analytics
This is repo for creating Dashboard of Armor Log data Analytics using BigQuery and Data Studio

## Why use the Google Cloud Armor Visibility Dashboard?

The Cloud Armor Visibility Dashboard? allows you to view and analsze  Google Global Load-Balancing security data related to Web Application Security (WAF), from Google Cloud Armor. The Visibility Dashboard gives you the ability to integrate security, traffic and web application metrics, to perform security monitoring and analysis of your Google Cloud resources protected by Cloud Armor. This gives location based insight about the traffic lets you drill down to final level of data.


## Getting Started

### Requirements
* Bigquery dataset exists
* Log data integrated with Bigquery Dataset
* Access to create tables/View in this Bigquery Dataset
* Data viewer access on this Bigquery Dataset


## Technical installation

### 1) Setup the Envirenment varaibles

    export USER_EMAIL=<email_id>
    export PROJECT_ID=<Project_id>
    export DATASET=<dataset name>
    export REGION=<region>


### 2) Execte the schema_setup.sh

      sh ./schema_setup.sh
      
### 3) Setup Looker Studio Dashboard for your dataset

#### a) Copy [this] (https://lookerstudio.google.com/c/u/0/reporting/794371be-a32c-4623-a388-9aa96b0c5e6a/page/04pID) Looker Dashboard 

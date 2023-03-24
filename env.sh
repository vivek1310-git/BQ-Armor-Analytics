##################################################
##
## Set these Variables
##
##################################################
# existing GCP user that will:
# create the project
# attach a billing id (needs to have permission)
# and provision resources
export USER_EMAIL=<email_id>

# project id for your NEW GCP project
export PROJECT_ID=<Project_id>

# the new project will need to be tied to a billing account, uncomment the line below for Argolis users and update value
# export DATASET=<dataset name>

# desired GCP region for networking and compute resources, EDIT region below based on your need
export REGION=us-central1


##################################################
#Example
##################################################
# export USER_EMAIL=myuser@mydomain.com
# export PROJECT_ID=gee-on-gcp
# export DATASET=log_analytics
# export REGION=us-central1
##################################################

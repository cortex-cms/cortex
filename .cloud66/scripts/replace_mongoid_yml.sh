#!/bin/bash

## Script to open up replace cloud66 mongoid.yml with a version sans :consistency option
## which has been depreciated in mongoid 4

# load environment variables
source /var/.cloud66_env

sudo cp $RAILS_STACK_PATH/config/mongoid.yml.hack $RAILS_STACK_PATH/config/mongoid.yml

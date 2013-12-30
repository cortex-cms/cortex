#!/bin/bash

## Script to open up permissions for Paperclip

# load environment variables
source /var/.cloud66_env

# assign desired permissions
sudo chmod 0777 -R $RAILS_STACK_PATH/public

#!/bin/bash
cd $STACK_PATH

bundle exec rake db:seed cortex:create_categories cortex:onet:fetch_and_provision

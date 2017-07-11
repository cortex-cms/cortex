#!/bin/bash
cd $STACK_PATH

bundle exec rake db:seed

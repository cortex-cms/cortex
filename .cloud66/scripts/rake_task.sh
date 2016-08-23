#!/bin/bash
cd $STACK_PATH
bundle exec rake cortex:rebuild_indexes
bundle exec rake metacortex:db:setup

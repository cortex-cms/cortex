#!/bin/bash
cd $STACK_PATH
bundle exec rake cortex:rebuild_indexes
bundle exec rake cortex:db:custom_content_core:reseed

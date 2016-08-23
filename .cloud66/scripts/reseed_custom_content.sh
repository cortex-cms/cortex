#!/bin/bash
cd $STACK_PATH
bundle exec rake cortex:custom_content_core:db:reseed

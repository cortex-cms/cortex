#!/bin/bash
cd $STACK_PATH
bundle exec rake cortex:core:db:reseed

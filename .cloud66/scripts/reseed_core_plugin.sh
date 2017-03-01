#!/bin/bash
cd $STACK_PATH

echo "Executing reseed_core_plugin in:"
pwd

bundle exec rake cortex:core:db:reseed

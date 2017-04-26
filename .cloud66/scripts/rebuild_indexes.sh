#!/bin/bash
cd $STACK_PATH

echo "Executing rebuild_indexes in:"
pwd

bundle exec rake cortex:rebuild_indexes

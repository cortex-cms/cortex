#!/bin/bash
cd $STACK_BASE/releases/$(ls -1 -t $STACK_BASE/releases/ | head -n1)

echo "Executing write_plugins_to_tmp in:"
pwd

env BUNDLE_GEMFILE=$STACK_BASE/releases/$(ls -1 -t $STACK_BASE/releases/ | head -n1)/Gemfile bundle exec rake cortex:plugins:write_to_tmp

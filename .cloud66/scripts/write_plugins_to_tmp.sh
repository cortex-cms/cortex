#!/bin/bash
cd $STACK_BASE/releases/$(ls -1 -t $STACK_BASE/releases/ | head -n1)
bundle exec rake cortex:plugins:write_to_tmp

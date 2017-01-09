#!/bin/bash
unset BUNDLE_GEMFILE
cd $STACK_BASE/releases/$(ls -1 -t $STACK_BASE/releases/ | head -n1)
bundle exec rake bower:install

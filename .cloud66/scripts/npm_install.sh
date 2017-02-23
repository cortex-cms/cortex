#!/bin/bash
cd $STACK_BASE/releases/$(ls -1 -t $STACK_BASE/releases/ | head -n1)
npm install

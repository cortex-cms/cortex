#!/bin/bash
cd $STACK_BASE/releases/$(ls -1 -t $STACK_BASE/releases/ | head -n1)

echo "Executing clobber_assets in:"
pwd

rm -rf public/assets/* app/assets/webpack/*

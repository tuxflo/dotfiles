#!/bin/sh

not_use_branches=`git branch --merged | grep -v "\*"`
for b in $not_use_branches; do
  git branch -d $b
done

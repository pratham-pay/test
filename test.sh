#!/bin/sh

if [ $BRANCH_NAME == "master" ]; then
  yes | make deploy ENV=prod'
else
yes | make deploy
fi

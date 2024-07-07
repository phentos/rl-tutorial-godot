#!/bin/bash

echo "Enter commit message:"
read msg

git fetch
git add .
git commit -m "$msg"
git pull --rebase
git push

echo "Press any key to exit...."
read -n 1 -s

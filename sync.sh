#! /bin/bash

rsync --delete --exclude .git -avze ssh . ec2:~/scripts

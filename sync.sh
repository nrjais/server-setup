#! /bin/bash

rsync --delete --exclude .git -avze ssh . oc:~/scripts

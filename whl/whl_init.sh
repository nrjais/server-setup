#!/usr/bin/env bash

apk add git

rm -rf /blog
git clone --depth=1 https://github.com/nrjais/blog.git /blog

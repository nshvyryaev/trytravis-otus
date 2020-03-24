#!/usr/bin/env bash

git clone -b monolith https://github.com/express42/reddit.git
pushd reddit
    bundle install
    puma -d
popd

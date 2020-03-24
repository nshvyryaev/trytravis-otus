#!/usr/bin/env bash
set -e

mv puma.service /etc/systemd/system/puma.service
systemctl daemon-reload
systemctl enable puma.service
cd /var
mkdir www
cd www
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install

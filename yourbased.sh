#!/usr/bin/env bash
set -ex

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y tzdata fonts-ipafont libpq-dev
gem install bundler -v 2.0.1
 


#install
bundle install --jobs=3 --retry=3

# before_script
# export DISPLAY=:99.0
# sh -e /etc/init.d/xvfb start

#script
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake spec

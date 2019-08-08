#!/usr/bin/env bash
set -ex

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install tzdata -y
gem install bundler -v 2.0.1
apt-get install fonts-ipafont




#install
bundle install --jobs=3 --retry=3

# before_script
export DISPLAY=:99.0
sh -e /etc/init.d/xvfb start

#script
rake

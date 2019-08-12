#!/usr/bin/env bash
set -ex

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y tzdata fonts-ipafont libpq-dev libyaml-dev postgresql-client libfontconfig
gem install bundler -v 2.0.1
export DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true 

rm -rf $PWD/travis_phantomjs; mkdir -p $PWD/travis_phantomjs
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -O $PWD/travis_phantomjs/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar -xvf $PWD/travis_phantomjs/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C $PWD/travis_phantomjs
PATH=$PWD/travis_phantomjs/phantomjs-2.1.1-linux-x86_64/bin:$PATH
phantomjs --version


#install
bundle install --jobs=3 --retry=3

# before_script
# export DISPLAY=:99.0
# sh -e /etc/init.d/xvfb start

#script
export RAILS_ENV=test
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake spec

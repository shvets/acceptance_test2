#!/usr/bin/env bash

##############################
# [init]
# Initializes project

sudo sh -c 'echo "source /usr/local/rvm/scripts/rvm" >> ~/.bash_login'
sudo sh -c 'echo "cd /vagrant" >> ~/.bash_login'
sudo sh -c 'echo "rvm use #{project.ruby_version}@#{project.gemset}" >> ~/.bash_login'

source /usr/local/rvm/scripts/rvm

rvm use #{project.ruby_version}@#{project.gemset} --create

gem install --no-rdoc --no-ri bundler
gem install --no-rdoc --no-ri rake


##############################
# [update]
# Updates project

cd "#{project.home}"

source /usr/local/rvm/scripts/rvm

rvm use #{project.ruby_version}@#{project.gemset}

bundle


##############################
# [start]
# Starts tests

cd #{project.home}

source /usr/local/rvm/scripts/rvm

rvm use #{project.ruby_version}@#{project.gemset}

HEADLESS=1 VIDEO=1 rake


#######################################
# [exec1]

PATH=/usr/local/bin:$PATH
PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"

cd #{project.home}

source /usr/local/rvm/scripts/rvm

rvm use #{project.ruby_version}@#{project.gemset}

echo $1

rspec spec/unit/wikipedia_search_spec.rb:55
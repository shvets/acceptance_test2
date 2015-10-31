#!/bin/sh

#######################################
# [test]

echo "Hello world!"


##############################
# [init]
# Installs project

sudo sh -c 'echo "source /usr/local/rvm/scripts/rvm" >> ~/.bash_login'
sudo sh -c 'echo "cd /vagrant" >> ~/.bash_login'
sudo sh -c 'echo "rvm use @@#{project.gemset}" >> ~/.bash_login'

source /usr/local/rvm/scripts/rvm

rvm use #{project.ruby_version}@#{project.gemset} --create

gem install --no-rdoc --no-ri bundler
gem install --no-rdoc --no-ri rake


##############################
# [update]
# Updates project

APP_HOME="#{project.home}"

cd $APP_HOME

source /usr/local/rvm/scripts/rvm

rvm use #{project.ruby_version}@#{project.gemset} --create

bundle


##############################
# [start]
# Starts tests

USER_HOME="#{node.home}"

APP_HOME="#{project.home}"

cd $APP_HOME

source /usr/local/rvm/scripts/rvm

rvm use #{project.ruby_version}@#{project.gemset}

HEADLESS=1 VIDEO=1 rake

#!/bin/sh


#######################################
# [ubuntu_update]
# Updates linux core packages

sudo apt-get update


#######################################
# [required_packages]
# Updates linux core packages

sudo apt-get update

sudo apt-get install -y curl
sudo apt-get install -y g++
sudo apt-get install -y subversion
sudo apt-get install -y git

# to support rvm

sudo apt-get install -y libreadline6-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libyaml-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y sqlite3
sudo apt-get install -y autoconf
sudo apt-get install -y libgdbm-dev
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y automake
sudo apt-get install -y libtool
sudo apt-get install -y bison
sudo apt-get install -y pkg-config
sudo apt-get install -y libffi-dev

# to support nokogiri
sudo apt-get install -y libgmp-dev

# to support capybara-webkit
sudo apt-get install -y libqt4-dev
sudo apt-get install -y libqtwebkit-dev

# to support headless
sudo apt-get install -y xvfb


#######################################
# [gpg]
# Installs gpg

sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3


#######################################
# [rvm]
# Installs rvm

curl -sSL https://get.rvm.io | bash


#######################################
# [ruby]
# Installs ruby

/usr/local/rvm/bin/rvm install 2.2.3


#######################################
# [ch_rights]
# Change rights for /usr/local

sudo chown -R vagrant /usr/local


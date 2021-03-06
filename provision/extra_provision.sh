#!/usr/bin/env bash

#######################################
# [chrome]

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt-get update

sudo apt-get install -y google-chrome-stable


#######################################
# [chromedriver]

sudo apt-get install -y unzip

wget -N http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip -P ~/Downloads

unzip ~/Downloads/chromedriver_linux64.zip -d ~/Downloads

chmod +x ~/Downloads/chromedriver

sudo mv -f ~/Downloads/chromedriver /usr/local/share/chromedriver

sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver

sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver


#######################################
# [ffmpeg]

sudo apt-get install -y ffmpeg
sudo apt-get install -y libav-tools


##############################
# [firefox]

sudo apt-get install -y firefox


##############################
# [phantomjs]

#sudo apt-get install phantomjs

cd /usr/local/share

sudo wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2

sudo tar xjf phantomjs-1.9.8-linux-x86_64.tar.bz2

sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/bin/phantomjs


##############################
# [imagemagick]

sudo apt-get install -y imagemagick
sudo apt-get install -y X11-apps


##############################
# [apache]

sudo apt-get install -y apache2


#######################################
# [node]
# Installs node

sudo apt-get install -y node


#######################################
# [rbenv]
# Installs node

sudo apt-get install -y rbenv
git clone git://github.com/jf/rbenv-gemset.git $HOME/.rbenv/plugins/rbenv-gemset



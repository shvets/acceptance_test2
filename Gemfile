source 'https://rubygems.org'

group :development do
  gem 'gemspec_deps_gen'
  gem 'gemcutter'
  gem 'thor', '0.19.1'
  gem 'pry'
end

group(:default) {
  gem 'script_executor', '1.7.7'
  gem 'parallel_tests', '2.6.0'

  if Gem::Platform.local.os.to_sym == :linux
    gem 'headless'
  end
}

group :minitest, :default do
  gem 'minitest'
  gem 'minitest-capybara'
  gem 'minitest-metadata'
  gem 'minitest-reporters'
end

# Note: for capybara-webkit you need to install qt first:
#
# Mac: brew install qt5 ; ln -s /usr/local/Cellar/qt5/5.6.1/bin/qmake /usr/local/bin/qmake
# Ubuntu: sudo apt-get install libqt4-dev libqtwebkit-dev
# Debian: sudo apt-get install libqt4-dev
# Fedora: yum install qt-webkit-devell

# for chrome support:
# brew install chromedriver

# Note: for poltergeist you have to install phantomjs first
# brew install phantomjs

group :capybara, :default do
  gem 'capybara'
  gem 'capybara-extensions'
  gem 'selenium-webdriver'
end

group :chrome_headless do
  gem 'capybara-selenium'
  gem 'chromedriver-helper'
end

# group :webkit do
#   gem "capybara-webkit"
# end

# group :poltergeist do
#   gem "poltergeist"
# end

group :rspec, :default do
  gem 'rspec'
end

group :turnip do
  gem "turnip"
  gem "turnip_formatter"
  gem "gnawrnip"
end

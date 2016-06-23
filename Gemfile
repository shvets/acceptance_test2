source 'https://rubygems.org'

group :development do
  gem "gemspec_deps_gen"
  gem "gemcutter"
end

group :default do
  gem 'thor', "~> 0.19.1"
  gem "script_executor", "~> 1.7.7"
  gem "parallel_tests", "~> 2.6.0"

  if Gem::Platform.local.os.to_sym == :linux
    gem "headless"
  end
end

group :minitest, :default do
  gem "minitest", "~> 5.9.0"
  gem "minitest-capybara", "~> 0.8.2"
  gem "minitest-metadata", "~> 0.6.0"
  gem "minitest-reporters", "~> 1.1.9"
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
  gem "capybara", "~> 2.7.1"
  gem "capybara-extensions", "~> 0.4.1"
  gem "selenium-webdriver", "~> 2.53.3"
end

# group :webkit do
#   gem "capybara-webkit", "~> 1.7.1"
# end
#
# group :poltergeist do
#   gem "poltergeist", "~> 1.9.0"
# end

group :rspec, :default do
  gem "rspec", "~> 3.4.0"
end

# group :turnip do
#   gem "turnip", "~> 2.1.1"
#   gem "turnip_formatter", "~> 0.5.0"
#   gem "gnawrnip", "~> 0.5.0"
#   #gem "turnip", :git => 'https://github.com/jnicklas/turnip.git', :branch => '2_0_0_rc1'
# end

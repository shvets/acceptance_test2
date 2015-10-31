source 'https://rubygems.org'

group :development do
  gem "gemspec_deps_gen"
  gem "gemcutter"
end

group :default do
  gem 'thor', "~> 0.19"
  gem "script_executor", "~> 1.7"
  gem "parallel_tests", "~> 1.6"

  if Gem::Platform.local.os.to_sym == :linux
    gem "headless"
  end
end

group :minitest, :default do
  gem "minitest", "~> 5.8.1"
  gem "minitest-capybara", "~> 0.7.2"
  gem "minitest-metadata", "~> 0.6.0"
  gem "minitest-reporters", "~> 1.1.2"
end

group :capybara, :default do
  gem "capybara", "~> 2.5.0"
  gem "capybara-extensions", "~> 0.4.1"
  gem "selenium-webdriver", "~> 2.47.1"
  gem "capybara-webkit", "~> 1.7.1"
end

group :rspec, :default do
  gem "rspec", "~> 3.3.0"
end

group :turnip, :default do
  gem "turnip", "~> 1.3.1"
  gem "turnip_formatter", "~> 0.3.4"
  gem "gnawrnip", "~> 0.3.2"
  #gem "turnip", :git => 'https://github.com/jnicklas/turnip.git', :branch => '2_0_0_rc1'
end

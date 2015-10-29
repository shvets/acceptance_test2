# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/lib/acceptance_test/version')

Gem::Specification.new do |spec|
  spec.name          = "acceptance_test"
  spec.summary       = %q{Simplifies congiguration and run of acceptance tests.}
  spec.description   = %q{Description: simplifies congiguration and run of acceptance tests.}
  spec.email         = "alexander.shvets@gmail.com"
  spec.authors       = ["Alexander Shvets"]
  spec.homepage      = "http://github.com/shvets/acceptance_test2"

  spec.files         = `git ls-files`.split($\)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.version       = AcceptanceTest::VERSION
  spec.license       = "MIT"

  
  spec.add_runtime_dependency "minitest", ["~> 5.8.1"]
  spec.add_runtime_dependency "minitest-capybara", ["~> 0.7.2"]
  spec.add_runtime_dependency "minitest-metadata", ["~> 0.6.0"]
  spec.add_runtime_dependency "minitest-reporters", ["~> 1.1.2"]
  spec.add_runtime_dependency "capybara", ["~> 2.5.0"]
  spec.add_runtime_dependency "capybara-extensions", ["~> 0.4.1"]
  spec.add_runtime_dependency "selenium-webdriver", ["~> 2.47.1"]
  spec.add_runtime_dependency "capybara-webkit", ["~> 1.7.1"]
  spec.add_runtime_dependency "rspec", ["~> 3.3.0"]
  spec.add_runtime_dependency "turnip", ["~> 1.3.1"]
  spec.add_runtime_dependency "turnip_formatter", ["~> 0.3.4"]
  spec.add_runtime_dependency "gnawrnip", ["~> 0.3.2"]
  spec.add_development_dependency "gemspec_deps_gen", [">= 0"]
  spec.add_development_dependency "gemcutter", [">= 0"]

  
end

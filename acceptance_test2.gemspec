# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/lib/acceptance_test/version')

Gem::Specification.new do |spec|
  spec.name          = "acceptance_test2"
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

  
  spec.add_runtime_dependency "thor", ["= 0.19.1"]
  spec.add_runtime_dependency "script_executor", ["= 1.7.7"]
  spec.add_runtime_dependency "parallel_tests", ["= 2.6.0"]
  spec.add_runtime_dependency "minitest", ["= 5.9.0"]
  spec.add_runtime_dependency "minitest-capybara", ["= 0.8.2"]
  spec.add_runtime_dependency "minitest-metadata", ["= 0.6.0"]
  spec.add_runtime_dependency "minitest-reporters", ["= 1.1.9"]
  spec.add_runtime_dependency "capybara", ["= 2.7.1"]
  spec.add_runtime_dependency "capybara-extensions", ["= 0.4.1"]
  spec.add_runtime_dependency "selenium-webdriver", ["= 2.53.3"]
  spec.add_runtime_dependency "rspec", ["= 3.4.0"]
  spec.add_development_dependency "gemspec_deps_gen", [">= 0"]
  spec.add_development_dependency "gemcutter", [">= 0"]

  
end

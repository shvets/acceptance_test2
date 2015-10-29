#!/usr/bin/env rake

$LOAD_PATH.unshift File.expand_path("lib", File.dirname(__FILE__))

require "rspec/core/rake_task"
require "acceptance_test/version"
require "gemspec_deps_gen/gemspec_deps_gen"

version = AcceptanceTest::VERSION
project_name = File.basename(Dir.pwd)

task :gen do
  generator = GemspecDepsGen.new

  generator.generate_dependencies "spec", "#{project_name}.gemspec.erb", "#{project_name}.gemspec"
end

task :build => :gen do
  system "gem build #{project_name}.gemspec"
end

task :install => :build do
  system "gem install #{project_name}-#{version}.gem"
end

task :uninstall do
  system "gem uninstall #{project_name}"
end

task :release => :build do
  system "gem push #{project_name}-#{version}.gem"
end

require 'rake/testtask'

task :default => :test

desc 'Run minitest tests'
Rake::TestTask.new do |t|
  t.libs.push %w(spec lib)
  t.test_files = FileList[
      #'spec/unit/wikipedia_search_test.rb',
      'spec/unit/google_search_test.rb'
  ]
  t.verbose = true
end

desc 'Run rspec tests'
RSpec::Core::RakeTask.new('rspec') do |t|
  t.pattern = "spec/unit/wikipedia_search_spec.rb"
  t.rspec_opts =  "--color"
end

desc 'Run turnip tests'
RSpec::Core::RakeTask.new('turnip') do |t|
  t.pattern = "spec/features/**/*.feature"
  t.rspec_opts =  "--color -Ispec/support/features -r turnip/rspec"
end


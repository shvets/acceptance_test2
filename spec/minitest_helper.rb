require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/capybara'
require 'minitest-metadata'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new # spec-like progress

$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require 'acceptance_test/minitest/acceptance_spec'
require 'acceptance_test/capybara/capybara_helper'

#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("lib", File.dirname(__FILE__))

require "thor"

class Test < Thor

  desc "minitest", "minitest"
  def minitest
    system "ruby spec/unit/wikipedia_search_test.rb"
  end

  desc "rspec", "rspec"
  def rspec
    system "rspec spec/unit/wikipedia_search_spec.rb"
  end

  desc "turnip", "turnip"
  def turnip
    system "rspec -r turnip/rspec spec/features/search_with_drivers.feature"
  end

end

if File.basename($0) != 'thor'
  Test.start
end

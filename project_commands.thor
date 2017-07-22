#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("lib", File.dirname(__FILE__))

require "thor"

require 'script_executor/base_provision'

class Project < Thor
  include Executable

  BaseProvision.new("provision/project.conf.json", [
    "provision/system_provision.sh",
    "provision/extra_provision.sh",
    "provision/project_provision.sh"
  ]).create_thor_methods(self)

  desc "cp_key", "cp_key"
  def cp_key
    system "thor ssh:cp_key vagrant 22.22.22.22"
    #execute { "thor ssh:cp_key vagrant 22.22.22.22" }
  end

  desc "ssh", "ssh"
  def ssh
    system "ssh vagrant@22.22.22.22"
    #execute { "ssh vagrant@22.22.22.22" }
  end

  desc "ubuntu_update", "ubuntu_update"
  def ubuntu_update
    invoke :ubuntu_update
  end

  desc "sys", "Installs system packages"
  def sys
    invoke :ubuntu_update
    invoke :required_packages
    invoke :gpg

    invoke :rvm
    invoke :ruby
  end

  desc "extra", "Installs extra packages"
  def extra
    invoke :chrome
    invoke :chromedriver
    invoke :ffmpeg
    invoke :firefox
    invoke :phantomjs

    # invoke :imagemagick
    # invoke :apache
    # invoke :node
    # invoke :rbenv
  end

  desc "prg", "Installs project related packages"
  def prg
    invoke :init
    invoke :update
  end

end

if File.basename($0) != 'thor'
  Project.start
end


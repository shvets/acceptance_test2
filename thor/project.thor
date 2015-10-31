$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'script_executor/base_provision'

class Project < Thor
  include Executable

   BaseProvision.new("thor/project.conf.json", [
    "thor/system_provision.sh",
    "thor/extra_provision.sh",
    "thor/project_provision.sh"
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
    invoke :prepare_linux
    invoke :rvm
    invoke :ruby

    #invoke :node

    invoke :prepare
  end

  desc "prg", "Installs project related packages"
  def prg
    invoke :init
    invoke :update

    invoke :ffmpeg
    invoke :firefox

    invoke :chrome
    invoke :chromedriver
  end

end

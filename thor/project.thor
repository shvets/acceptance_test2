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

  desc "exec", "Executes command on remote server"
  def exec *args
    if args
      invoke :exec1, 'a'
      #system "ssh vagrant@22.22.22.22 \'cd /home/vagrant && source /usr/local/rvm/scripts/rvm && /usr/local/rvm/bin/rvm use @acceptance_test2 && #{args.join(' ')}\'"
    end
  end

end

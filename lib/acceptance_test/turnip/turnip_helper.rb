require 'singleton'

require 'turnip/capybara'

class TurnipHelper
  include Singleton

  def configure(title: 'Turnip', report_file:, steps_dir:)
    # configure turnip formatter

    require 'turnip_formatter'

    RSpec.configure do |config|
      config.add_formatter RSpecTurnipFormatter, report_file
    end

    TurnipFormatter.configure do |config|
      config.title = title
    end

    # configure gnawrnip

    require 'gnawrnip'

    Gnawrnip.configure do |c|
      c.make_animation = true
      c.max_frame_size = 1024 # pixel
    end

    Gnawrnip.ready!

    load_steps [steps_dir]
  end

  def load_steps support_dirs
    support_dirs.each do |support_dir|
      Dir["#{support_dir}/**/steps/*_steps.rb"].each do |name|
        ext = File.extname(name)
        name = name[support_dir.length+1..name.length-ext.length-1]

        require name
      end
    end
  end

end
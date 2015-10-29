require 'bundler/setup'

require 'acceptance_test/rspec/rspec_helper'
require 'acceptance_test/turnip/turnip_helper'

$LOAD_PATH.unshift File.expand_path("../spec/support/features", File.dirname(__FILE__))

RspecHelper.instance.configure app_host: "http://wikipedia.org"

TurnipHelper.instance.configure report_file: 'output/wikipedia-turnip-report.html', steps_dir: "spec/support/features"

cmd = 'open -a "/Applications/Google Chrome.app" output/wikipedia-turnip-report.html'

RspecHelper.instance.run_on_specs_finished(cmd)



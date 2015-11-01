require 'rspec'
require 'rspec/expectations'

require 'capybara/rspec'
require 'capybara/dsl'

require 'singleton'

require 'acceptance_test/capybara/capybara_helper'

class RspecHelper
  include Singleton

  def configure(app_host:, driver: CapybaraHelper::DEFAULT_DRIVER, browser: CapybaraHelper::DEFAULT_BROWSER,
                wait_time: CapybaraHelper::DEFAULT_WAIT_TIME)
    register_extensions

    RSpec.configure do |rspec_config|
      params = {app_host: app_host, driver: driver, browser: browser, wait_time: wait_time}

      RspecHelper.instance.configure_rspec rspec_config, params
    end
  end

  def create_shared_context(name)
    register_extensions

    RSpec.shared_context name do |app_host:, driver: CapybaraHelper::DEFAULT_DRIVER, browser: CapybaraHelper::DEFAULT_BROWSER,
        wait_time: CapybaraHelper::DEFAULT_WAIT_TIME|
      self.define_singleton_method(:include_context, lambda do
        params = {app_host: app_host, driver: driver, browser: browser, wait_time: wait_time}

        RspecHelper.instance.configure_rspec self, params
      end)

      include_context
    end
  end

  def configure_rspec(rspec_config, app_host:, driver: CapybaraHelper::DEFAULT_DRIVER, browser: CapybaraHelper::DEFAULT_BROWSER,
                      wait_time: CapybaraHelper::DEFAULT_WAIT_TIME)
    rspec_config.around(:each) do |example|
      params = {metadata: example.metadata, app_host: app_host, driver: driver, browser: browser, wait_time: wait_time}

      RspecHelper.instance.before_test params

      example.run

      RspecHelper.instance.after_test metadata: example.metadata, exception: example.exception
    end
  end

  def before_test metadata:, app_host:, driver:, browser:, wait_time:
    old_driver = Capybara.current_driver

    selected_driver = RspecHelper.instance.get_driver(metadata, driver: driver)
    selected_browser = RspecHelper.instance.get_browser(metadata, browser: browser)

    params = {app_host: app_host, driver: selected_driver, browser: selected_browser, wait_time: wait_time}

    CapybaraHelper.instance.before_test params

    new_driver = Capybara.current_driver

    Capybara.current_session.instance_variable_set(:@mode, new_driver)

    if old_driver != new_driver
      metadata.delete(old_driver)
      metadata[new_driver] = true
    end
  end

  def after_test(metadata: nil, exception: nil)
    CapybaraHelper.instance.after_test name: File.basename(metadata[:file_path]), exception: exception

    #   driver = driver(example.metadata)
    #
    #   if driver and exception and page and not [:webkit].include? driver
    #     screenshot_maker.basedir = File.expand_path(config[:screenshots_dir])
    #
    #     screenshot_maker.make page, example.metadata
    #
    #     puts example.metadata[:full_description]
    #     puts "Screenshot: #{screenshot_maker.screenshot_url(example.metadata)}"
    #   end
    #
  end

  def register_extensions
    RSpec.configure do |conf|
      conf.filter_run_excluding :exclude => true
    end

    RSpec::configure do |config|
      config.include RSpec::Matchers::DSL
      config.include Capybara::RSpecMatchers
      config.include Capybara::DSL
    end

    # RSpec::Core::ExampleGroup.send :include, Capybara::DSL
  end

  def get_driver(metadata, driver:)
    driver_name = driver

    driver_name = metadata[:driver] unless driver_name

    supported_drivers.each do |supported_driver|
      driver_name = supported_driver if metadata[supported_driver]
      break if driver
    end if driver.nil?

    driver_name = :selenium unless driver_name

    driver_name
  end

  def get_browser(metadata, browser:)
    browser_name = browser

    browser_name = metadata[:browser] unless browser_name

    supported_browsers.each do |supported_browser|
      browser_name = supported_browser if metadata[supported_browser]
      break if browser
    end if browser.nil?

    browser_name = CapybaraHelper::DEFAULT_BROWSER unless browser_name

    browser_name
  end

  def supported_drivers
    [:selenium, :webkit, :poltergeist]
  end

  def supported_browsers
    [:chrome, :firefox]
  end

  def run_on_specs_finished command
    clazz = Object.const_set("CustomFormatter", Class.new)

    clazz.class_eval do
      define_method :initialize do |_| ; end

      define_method :close do |_|
        system command

        # require 'launchy'
        #
        # ENV['BROWSER'] = '/Applications/Google\ Chrome.app'
        #
        # Launchy.open "output/wikipedia-turnip-report.html"
      end
    end

    RSpec::Core::Formatters.register clazz, :close

    RSpec::configure do |config|
      config.formatter = "CustomFormatter"
    end

    # RSpec.configure do |config|
    #   config.after(:type => :feature) do
    #     system cmd
    #   end
    # end
  end
end


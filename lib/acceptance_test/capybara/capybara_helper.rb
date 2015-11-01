require 'singleton'
require 'capybara'

class CapybaraHelper
  include Singleton

  DEFAULT_DRIVER = :selenium
  DEFAULT_BROWSER = :chrome
  DEFAULT_WAIT_TIME = 2

  attr_reader :headless_mode, :video_mode, :parallel_tests_mode

  def initialize
    Capybara.run_server = false

    if ENV['HEADLESS']
      begin
        require 'headless'

        @headless_mode = true
      rescue LoadError
        @headless_mode = false

        headless_mode_not_supported
      end
    end

    @video_mode = ENV['VIDEO'] ? true : false

    @parallel_tests_mode = ENV['TEST_ENV_NUMBER'] ? true : false
  end

  def before_test(app_host:, driver: DEFAULT_DRIVER, browser: DEFAULT_BROWSER, wait_time: DEFAULT_WAIT_TIME)
    @old_driver = Capybara.current_driver

    driver_name = register_driver driver: driver, browser: browser, selenium_url: nil, capabilities: nil

    use_driver(driver_name)

    Capybara.app_host = app_host

    @old_default_max_wait_time = Capybara.default_max_wait_time

    Capybara.configure do |conf|
      conf.default_max_wait_time = wait_time
    end

    if headless_mode
      headless_params = {}
      headless_params[:display] = 100 + test_number
      headless_params[:reuse] = parallel_tests_mode ? true : false
      headless_params[:dimensions] = "1280x900x24"

      headless_params[:video] = {
        frame_rate: 12,
        provider: :ffmpeg,
        codec: :libx264,
        pid_file_name:  "/tmp/.headless_ffmpeg_#{test_number}.pid",
        tmp_file_name:  "/tmp/.headless_ffmpeg_#{test_number}.mp4",
        extra: ['-pix_fmt yuv420p', '-b 6144k', '-b 6144k'],
        log_file_path: STDERR
      } if video_mode

      begin
        @headless = Headless.new headless_params

        @headless.start

        @headless.video.start_capture if video_mode
      rescue Headless::Exception
        @headless_mode = false

        headless_mode_not_supported
      end
    end

    driver_name
  end

  def after_test name: nil, exception: nil
    Capybara.default_driver = @old_driver
    Capybara.current_driver = @old_driver
    Capybara.javascript_driver = @old_driver

    Capybara.app_host = nil

    Capybara.configure do |conf|
      conf.default_max_wait_time = @old_default_max_wait_time
    end

    if headless_mode
      if video_mode
        @headless.video.stop_and_save success_video_name(name)
      else
        if exception
          @headless.video.stop_and_save error_video_name(name, exception)
        else
          @headless.video.stop_and_discard
        end
      end

      @headless.destroy
    end
  end

  def take_screenshot
    file_path = '/vagrant/screenshot.jpg'

    if headless_mode
      @headless.take_screenshot file_path, {using: :imagemagick}
    end
  end

  private

  def test_number
    parallel_tests_mode ? ENV['TEST_ENV_NUMBER'].to_i : 1
  end

  def error_video_name name, exception
    exception_name = exception ? exception.name : 'exception'

    "#{exception_name}_#{name}.mp4"
  end

  def success_video_name name
    "#{name}.mp4"
  end

  def headless_mode_not_supported
    puts "Headless mode is not supported on this OS."
  end

  def register_driver driver:, browser: DEFAULT_BROWSER, selenium_url: nil, capabilities: nil
    driver_name = build_driver_name(driver: driver, browser: browser, selenium_url: selenium_url)

    if driver == :selenium
      properties = {}

      if not selenium_url
        properties[:browser] = browser
      else
        properties[:browser] = :remote
        properties[:url] = selenium_url

        case browser
          when :firefox
            # profile = Selenium::WebDriver::Firefox::Profile.new
            # profile.enable_firebug
            # capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile)

            caps = Selenium::WebDriver::Remote::Capabilities.firefox
          when :chrome
            caps = Selenium::WebDriver::Remote::Capabilities.chrome
          else
            caps = nil
        end

        desired_capabilities =
            if caps
              capabilities.each do |key, value|
                caps[key] = value
              end if capabilities

              caps
            elsif capabilities
              capabilities
            end

        properties[:desired_capabilities] = desired_capabilities if desired_capabilities
      end

      Capybara.register_driver driver_name do |app|
        Capybara::Selenium::Driver.new(app, properties)
      end
    end

    driver_name
  end

  def build_driver_name driver:, browser:, selenium_url: nil
    case driver
      when :webkit
        :webkit
      when :selenium
        name = ""
        name += driver ? "#{driver}_" : "#{Capybara.default_driver}_"

        name += "#{browser}_" if browser
        name += "remote" if selenium_url
        name = name[0..name.size-2] if name[name.size-1] == "_"

        name.to_sym
      else
        :unsupported
    end
  end

  def use_driver driver
    if driver and Capybara.drivers[driver]
      # Capybara.default_driver = driver
      Capybara.current_driver = driver
      Capybara.javascript_driver = driver
    end
  end
end

require_relative '../rspec_helper'

config = {app_host: "http://wikipedia.org", wait_time: 15, driver: :headless_chrome}

# CapybaraHelper.instance.register_driver(:webkit)
# CapybaraHelper.instance.register_driver(:poltergeist)

require "selenium/webdriver"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome
Capybara.current_driver = :headless_chrome

RspecHelper.instance.create_shared_context "WikipediaSearch"

RSpec.describe 'Wikipedia Search' do
  include_context "WikipediaSearch", config

  it "searches on wikipedia web site (selenium)" do
    puts Capybara.current_driver
    #expect(Capybara.current_driver).to equal(:selenium_chrome)

    visit('/')

    fill_in "searchInput", :with => "Capybara"

    find(".pure-button", match: :first).click

    expect(page).to have_content "Hydrochoerus hydrochaeris"
  end

  # describe do
  #   before do
  #     Capybara::Webkit.configure do |c|
  #       c.allow_url("upload.wikimedia.org")
  #       c.allow_url("en.wikipedia.org")
  #       c.allow_url("wikipedia.org")
  #       c.allow_url("meta.wikimedia.org")
  #       c.allow_url("login.wikimedia.org")
  #     end
  #   end
  #
  #   it "searches on wikipedia web site (webkit)", driver: :webkit do
  #     puts "driver: #{Capybara.current_driver}"
  #     expect(Capybara.current_driver).to equal(:webkit)
  #
  #     visit('/')
  #
  #     fill_in "searchInput", :with => "Capybara"
  #
  #     find(".formBtn", match: :first).click
  #
  #     expect(page).to have_content "Hydrochoerus hydrochaeris"
  #   end
  # end

  # it "searches on wikipedia web site (poltergeist)", driver: :poltergeist do
  #   if Gem::Platform.local.os.to_sym == :darwin
  #     puts "This OS: #{Gem::Platform.local.os} doesn't support phantomjs."
  #   else
  #     expect(Capybara.current_driver).to equal(:poltergeist)
  #
  #     visit('/')
  #
  #     fill_in "searchInput", :with => "Capybara"
  #
  #     find(".formBtn", match: :first).click
  #
  #     expect(page).to have_content "Hydrochoerus hydrochaeris"
  #   end
  # end
end
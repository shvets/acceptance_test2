require_relative '../rspec_helper'

config = {app_host: "http://wikipedia.org", wait_time: 15}

CapybaraHelper.instance.register_driver(:webkit)
CapybaraHelper.instance.register_driver(:poltergeist)

RspecHelper.instance.create_shared_context "WikipediaSearch"

RSpec.describe 'Wikipedia Search' do
  include_context "WikipediaSearch", config

  it "searches on wikipedia web site" do
    expect(Capybara.current_driver).to equal(:selenium_chrome)

    visit('/')

    fill_in "searchInput", :with => "Capybara"

    find(".formBtn", match: :first).click

    expect(page).to have_content "Hydrochoerus hydrochaeris"
  end

  describe do
    before do
      Capybara::Webkit.configure do |c|
        c.allow_url("upload.wikimedia.org")
        c.allow_url("en.wikipedia.org")
        c.allow_url("wikipedia.org")
        c.allow_url("meta.wikimedia.org")
        c.allow_url("login.wikimedia.org")
      end
    end

    it "searches on wikipedia web site", driver: :webkit do
      puts "driver: #{Capybara.current_driver}"
      expect(Capybara.current_driver).to equal(:webkit)

      visit('/')

      fill_in "searchInput", :with => "Capybara"

      find(".formBtn", match: :first).click

      expect(page).to have_content "Hydrochoerus hydrochaeris"
    end
  end

  it "searches on wikipedia web site", driver: :poltergeist do
    unless Gem::Platform.local.os.to_sym == :darwin
      puts "driver: #{Capybara.current_driver}"
      expect(Capybara.current_driver).to equal(:poltergeist)

      visit('/')

      fill_in "searchInput", :with => "Capybara"

      find(".formBtn", match: :first).click

      expect(page).to have_content "Hydrochoerus hydrochaeris"
    end
  end
end
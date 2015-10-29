require_relative '../rspec_helper'

config = {app_host: "http://wikipedia.org", wait_time: 15}

RspecHelper.instance.create_shared_context "WikipediaSearch"

RSpec.describe 'Wikipedia Search' do
  include_context "WikipediaSearch", config

  it "searches on wikipedia web site" do
    visit('/')

    fill_in "searchInput", :with => "Capybara"

    find(".formBtn", match: :first).click

    expect(page).to have_content "Hydrochoerus hydrochaeris"
  end
end
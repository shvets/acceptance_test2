require_relative '../minitest_helper'

class WikipediaSearchTest < MinitestSpec

  Minitest::Spec.spec_type "Wikipedia Search", %q{
    As a visitor
    I want to be able to see results related to the search term I submit
    So that I can find what I'm looking for
  }

  before do
    config = {app_host: "http://wikipedia.org", wait_time: 15}

    CapybaraHelper.instance.before_test config
  end

  after do
    CapybaraHelper.instance.after_test
  end

  it "finding the information about capybara", js: true do
    visit "/"

    fill_in "searchInput", :with => "capybara"

    find(".pure-button", match: :first).click # submit

    page.must_have_content('capybara')
  end
end

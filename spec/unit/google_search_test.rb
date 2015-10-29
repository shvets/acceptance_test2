require_relative '../minitest_helper'

class GoogleSearchTest < AcceptanceSpec

  Minitest::Spec.spec_type "Google Search", %q{
    As a visitor
    I want to be able to see results related to the search term I submit
    So that I can find what I'm looking for
  }

  before do
    config = {app_host: "http://www.google.com", wait_time: 15}

    CapybaraHelper.instance.before_test config
  end

  after do
    CapybaraHelper.instance.after_test
  end

  it "finding the answer to the question of life", js: true do
    visit "/"

    #CapybaraHelper.instance.take_screenshot

    fill_in "q", :with => "the answer to the question of life"

    find(:xpath, "//button[@name='btnG']").click # submit

    page.must_have_content('42')
    #assert page.has_content?("42")
    #expect(page).to have_text("42")
  end
end

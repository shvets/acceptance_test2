require 'steps/common_steps'

steps_for :search_with_drivers do
  include CommonSteps

  step "I am on wikipedia.com" do
    visit('/')
  end

  step "I enter word :word" do |word|
    fill_in "searchInput", :with => word
  end

  step "I submit request" do
    find(".sprite-icons-search-icon", match: :first).click
  end

end

steps_for :search_with_scenario_outline do

  step "I am on wikipedia.com" do
    visit('/')
  end

  step "I enter word :word" do |word|
    fill_in "searchInput", :with => word
  end

  step "I submit request" do
    find(".formBtn", match: :first).click
  end

  step "I should see :text" do |text|
    expect(page).to have_content text
  end
end

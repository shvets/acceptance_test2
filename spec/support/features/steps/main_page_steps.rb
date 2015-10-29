module MainPageSteps
  step :visit_home_page, "I am on wikipedia.com"
  def visit_home_page
    visit('/')
  end

  step :enter_word, "I enter word :word"
  def enter_word  word
    fill_in "searchInput", :with => word
  end

  step :submit_request, "I submit request"
  def submit_request
    find(".formBtn", match: :first).click
  end
end
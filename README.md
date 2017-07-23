# AcceptanceTest v. 2 - Gem that simplifies configuration and running of acceptance tests

## Installation

Add this line to to your Gemfile:

```ruby
gem "acceptance_test"
```

And then execute:

```bash
$ bundle
```

## Usage

# With minitest

```ruby
require 'minitest/autorun'
require 'minitest/capybara'
require 'minitest-metadata'

require 'acceptance_test/minitest/acceptance_test'
require 'acceptance_test/capybara/capybara_helper'

class GoogleSearchTest < AcceptanceSpec

  before do
    config = {app_host: "http://www.google.com"}

    CapybaraHelper.instance.before_test config
  end

  after do
    CapybaraHelper.instance.after_test
  end

  it "finding the answer to the question of life" do
    visit "/"

    fill_in "q", :with => "the answer to the question of life"

    find(:xpath, "//button[@name='btnG']").click # submit

    page.must_have_content('42')
  end
end
```

# With rspec

```ruby
require 'acceptance_test/rspec/rspec_helper'

config = {app_host: "http://wikipedia.org"}

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
```

# With turnip

```ruby
# turnip_helper.rb

require 'acceptance_test/rspec/rspec_helper'
require 'acceptance_test/turnip/turnip_helper'

$LOAD_PATH.unshift File.expand_path("../spec/support/features", File.dirname(__FILE__))

RspecHelper.instance.configure app_host: "http://wikipedia.org"

TurnipHelper.instance.configure report_file: 'output/wikipedia-turnip-report.html', steps_dir: "spec/support/features"

cmd = 'open -a "/Applications/Google Chrome.app" output/wikipedia-turnip-report.html'

RspecHelper.instance.run_on_specs_finished(cmd)
```

```ruby
module CommonSteps
  step "I should see :text" do |text|
    expect(page).to have_content text
  end
end
```

```ruby
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
    find(".formBtn", match: :first).click
  end

end
```

```ruby
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
```

```ruby
require 'steps/common_steps'
require 'steps/main_page_steps'

steps_for :search_with_pages do
  include CommonSteps
  include MainPageSteps
end
```

```feature
Feature: Using Wikipedia

  @selenium
  @search_with_drivers
  Scenario: Searching with selenium for a term with submit

    Given I am on wikipedia.com
    When I enter word "Capybara"
    And I submit request
    Then I should see "Hydrochoerus hydrochaeris"

  @webkit
  @search_with_drivers
  Scenario: Searching with selenium for a term with submit

    Given I am on wikipedia.com
    When I enter word "Capybara"
    And I submit request
    Then I should see "Hydrochoerus hydrochaeris"
```

```feature
Feature: Using Wikipedia

  @search_with_pages
  Scenario: Searching with selenium for a term with submit

    Given I am on wikipedia.com
    When I enter word "Capybara"
    And I submit request
    Then I should see "Capybara"
```

# Using Vagrant

1. Install Virtual Box & Vagrant from executables

2. Start Vagrant

vagrant up



    Capybara resources:

https://github.com/wojtekmach/minitest-capybara
https://dockyard.com/blog/2013/11/11/capybara-extensions
http://www.elabs.se/blog/51-simple-tricks-to-clean-up-your-capybara-tests
https://robots.thoughtbot.com/write-reliable-asynchronous-integration-tests-with-capybara
https://robots.thoughtbot.com/headless-feature-specs-with-chrome

https://gist.github.com/MicahElliott/2407918

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

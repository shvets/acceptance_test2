require 'minitest/spec'
require 'capybara'

class MinitestSpec < MiniTest::Spec
  include Capybara::DSL
  include Capybara::Assertions

  before do
    if metadata[:js]
      Capybara.current_driver = Capybara.javascript_driver
    else
      Capybara.current_driver = Capybara.default_driver
    end
  end

  def teardown
    Capybara.reset_session!
    Capybara.use_default_driver
  end
end

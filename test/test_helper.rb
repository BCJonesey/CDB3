ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'factory_girl'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  

  # Add more helper methods to be used by all tests here...
end


class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
      Capybara.reset_sessions!
      Capybara.use_default_driver
  end

  def create_authenticated_session(user, password)
    open_session do |sess|
      sess.post session_url, params: {:email => user.email, :password => password}
    end
  end


end

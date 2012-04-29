require 'test_helper'

class FirstRunTest < ActionDispatch::IntegrationTest 
  test "first run" do
    Member.destroy_all
    User.destroy_all
    visit root_url
    assert_equal new_user_path, current_path
    within("div.alert.alert-success") do
      assert has_content?("This is a first run, please create an initial user account.")
    end
  end
end

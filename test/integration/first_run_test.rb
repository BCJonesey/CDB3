require 'test_helper'

class FirstRunTest < ActionDispatch::IntegrationTest 
  test "first run" do
    Member.destroy_all
    User.destroy_all
    visit root_url
    assert_equal new_user_path, current_path
    within(".flash_notice_message") do
      assert has_content?("Notice: This is a first run, please create an initial user account.")
    end
  end
end

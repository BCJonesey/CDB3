require 'test_helper'

class AddUserTest < ActionDispatch::IntegrationTest 
  test "add a user" do
    admin_user = Factory(:user, :global_admin => true)
    visit root_url
    
    click_link 'Log In'
    fill_in 'Email', :with => admin_user.email
    click_button 'Log In'
    
    click_link 'Administer Users'
    click_link 'New User'
    
    fill_in 'Name', :with => 'Awesome McPhat'
    fill_in 'Email', :with => 'Awesome@example.com'
    click_button 'Create User'
    
    within(".flash_notice_message") do
      assert has_content?("Notice: User was successfully created.")
    end
    
    assert_equal 'awesome@example.com', User.find_by_name('Awesome McPhat').email
  end
end

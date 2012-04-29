require 'test_helper'

class AddUserTest < ActionDispatch::IntegrationTest 
  test "add a user" do
    admin_user = Factory(:user, :global_admin => true)
    visit root_url
    
    click_link 'Log In'
    fill_in 'Email', :with => admin_user.email
    click_button 'Log In'
    
    click_link 'Administer Users'
    click_link 'New'
    
    fill_in 'Name', :with => 'Awesome McPhat'
    fill_in 'Email', :with => 'Awesome@example.com'
    click_button 'Create User'
    
    within("div.alert.alert-success") do
      assert has_content?("User was successfully created.")
    end
    
    assert_equal 'awesome@example.com', User.find_by_name('Awesome McPhat').email
  end
end

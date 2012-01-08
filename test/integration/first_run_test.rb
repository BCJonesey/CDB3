require 'test_helper'

class FirstRunTest < ActionDispatch::IntegrationTest
 

   test "first run" do
    User.destroy_all
    get '/' 
    assert_redirected_to new_user_path
    assert_nil session[:user_id]
    assert_equal flash[:notice], "This is a fist run, please create an initial user account."
   end
   
  
end


class MainController < ApplicationController
    before_filter :first_run_check
  
  def first_run_check
    if(User.count < 1 )
      redirect_to new_user_path, :notice => "This is a fist run, please create an initial user account."
    end
  end
  
  def index
  end

  def login
    @user = User.find_by_email(params[:email])

    if @user.nil?
      session[:user_id] = nil
      redirect_to '/', :alert => "No such user"
      return
    else
      session[:user_id] = @user.id
      redirect_to '/games', :notice => "Logged in as #{@user.name}"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/', :notice => "Logged out"
  end
end

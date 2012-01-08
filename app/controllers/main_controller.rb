
class MainController < ApplicationController
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
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/', :notice => "Logged out"
  end
end

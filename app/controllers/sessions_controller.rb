class SessionsController < ApplicationController
  def create
    user = login params[:email], params[:password], params[:remember_me]
    if user
    	redirect_back_or_to root_url, :notice => "Logged in as #{user.name}"
    else
		flash[:alert] = "Invalid email or password"
		redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end

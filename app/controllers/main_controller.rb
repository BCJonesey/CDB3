
class MainController < ApplicationController
  before_filter :first_run_check
  
  def first_run_check
    if User.count < 1
      redirect_to new_user_path, 
        :notice => "This is a first run, please create an initial user account."
      return
    end
  end
  
  def index
    session[:request_path] = '/'
    
    @games  = Game.all.find_all {|g| g.public? }
    @events = Event.all 
  end

  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = nil
      if request.post?
        session[:user_id] = user.id
	session[:request_path] ||= '/games'
	redirect_to session[:request_path], :notice => "Logged in as #{user.name}"
      end
    else
      flash[:alert] = "Invalid email or password"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/', :notice => "Logged out"
  end
end

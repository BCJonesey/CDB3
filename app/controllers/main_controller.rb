class MainController < ApplicationController
  def index
  end

  def login
    @user = User.find_by_email(params[:email])

    if @user.nil?
      redirect_to '/', :alert => "No such user"
      return
    end
  end

  def logout
  end

end

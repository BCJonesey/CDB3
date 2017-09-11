class UserMailer < ActionMailer::Base
  default from: "ninja@larp.ninja"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to LARP.ninja")
  end
end

class UserMailer < ActionMailer::Base
  default from: "bcjonsey@gmail.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to the LARP Tool")
  end
end

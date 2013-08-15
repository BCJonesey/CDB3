class UserMailer < ActionMailer::Base
  default from: "noreply@cerberusentertainment.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to the LARP Tool")
  end
end

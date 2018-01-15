class UserMailer < ActionMailer::Base
  default from: "ninja@larp.ninja"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to LARP.ninja")
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(:to => user.email,
         :subject => "Your password has been reset")
  end
end

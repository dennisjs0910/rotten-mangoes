class UserMailer < ActionMailer::Base
  default from: "mr.super.admin@info.com"

  def welcome_email(user)
    @user = user
    @url  = movies_path
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def bye_email(user)
    @admin = @current_user
    @user = user
    @url  = movies_path
    mail(to: @user.email, subject: 'Goodbye')
  end
end

class NotificationMailer < ActionMailer::Base
  default from: "propellerheaven@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail to: user.email
  end
end


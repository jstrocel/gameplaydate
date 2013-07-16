class Notifier < ActionMailer::Base
  default :from => 'no-reply@gameplaydate.com'
 
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Welcome to GamePlayDate!")
  end
  
  def password_reset(user)
      @user = user
      mail :to => user.email, :subject => "Password Reset"
  end
  
  def send_invite(user, event)
    @user = user
    @event = event
    mail :to => user.email, :subject => "You have been invited to play!"
  end
end
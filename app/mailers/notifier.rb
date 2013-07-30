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
    mail :to => user.email, :subject => "You have been invited to play #{event.game.name}!"
  end
  
  def accept_email(invite)
    @user = invite.user
    @organizer = invite.event.organizer
    mail :to => @organizer.email, :subject => "#{@user.name} has accepted your invite!"
  end
  
  def cancel_email(invite)
     @user = invite.user
      @organizer = invite.event.organizer
      mail :to => @organizer.email, :subject => "#{@user.name} has cancelled."
  end
end
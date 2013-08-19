class Notifier < ActionMailer::Base
  layout 'email'
  default :from => 'GamePlayDate.com <no-reply@gameplaydate.com>'
  
 
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Welcome to GamePlayDate!")
  end
  
  def password_reset(user)
      @user = user
      mail :to => user.email, :subject => "Password Reset"
  end
  
  def send_beta_invite(beta_invitation, signup_url)
      @beta_invitation = beta_invitation
      @sender = beta_invitation.sender
      @signup_url = signup_url
     @subject =  "#{@sender.name} has invited you to GamePlayDate"
      mail :to => @beta_invitation.recipient_email, :subject => @subject
      @beta_invitation.update_attribute(:sent_at, Time.now)
  end
  
  def send_invite(user, event)
    @user = user
    @event = event
    mail :to => user.email, :subject => "You have been invited to play #{event.game.name}!"
  end
  
  def accept_email(invite)
    @user = invite.user
    @organizer = invite.event.organizer
    @event = invite.event
    mail :to => @organizer.email, :subject => "#{@user.name} has accepted your invite!"
  end
  
  def cancel_email(invite)
     @user = invite.user
     @event = invite.event
      @organizer = invite.event.organizer
      mail :to => @organizer.email, :subject => "#{@user.name} has cancelled."
  end
end
class Notifier < AsyncMailer
  layout 'email'
  default :from => 'GamePlayDate.com <no-reply@gameplaydate.com>'
  
 
  def registration_confirmation(user_id)
    user = User.find_by_id(user_id)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Welcome to GamePlayDate!")
  end
  
  def password_reset(user_id)
      @user = User.find(user_id)
      mail :to => @user.email, :subject => "Password Reset"
  end
  
  def send_beta_invite(beta_invitation_id)
      @beta_invitation =BetaInvitation.find(beta_invitation_id)
      @sender = @beta_invitation.sender
      @signup_url = beta_signup_url(@beta_invitation.token)
     @subject =  "#{@sender.name} has invited you to GamePlayDate"
      mail :to => @beta_invitation.recipient_email, :subject => @subject
      @beta_invitation.update_attribute(:sent_at, Time.now)
  end
  
  def send_invite(user_id, event_id)
    @user = User.find(user_id)
    @event = Event.find(event_id)
    mail :to => @user.email, :subject => "You have been invited to play #{@event.game.name}!"
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
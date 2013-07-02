class Notifier < ActionMailer::Base
  default :from => 'no-reply@gameplaydate.com'
 
  def registration_confirmation(user)
    @user = user
    #@confirmation_url = confirmation_url(user)
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Welcome to GamePlayDate!")
  end
  
  def password_reset(user)
      @user = user
      mail :to => user.email, :subject => "Password Reset"
    end
end
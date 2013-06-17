class Notifier < ActionMailer::Base
  default :from => 'no-reply@gameplaydate.com'
 
  def registration_confirmation(user)
    @user = user
    #@confirmation_url = confirmation_url(user)
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Welcome to GamePlayDate!")
  end
end
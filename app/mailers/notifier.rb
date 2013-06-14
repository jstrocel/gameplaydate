class Notifier < ActionMailer::Base
  default :from => 'noreply@company.com'
 
  def registration_confirmation(user)
    @name = user.name
    #@confirmation_url = confirmation_url(user)
    mail :to => user.email, :subject => 'Welcome to GamePlayDate!'
  end
end
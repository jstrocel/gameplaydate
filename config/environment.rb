# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Gameplaydate::Application.initialize!

/ActionMailer::Base.smtp_settings = {
  :address              => "mail.gameplaydate.com",
  :port                 => 587,
  :domain               => "gameplaydate.com",
  :user_name            => "no-reply@gameplaydate.com",
  :password             => "wo4ghu4luru5to",
  :authentication       => :login,
  :enable_starttls_auto => false
}/

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['jtstrocel'],
  :password       => ENV['sha0roth6tu8gi'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}

class ReminderMailer < ActionMailer::Base
  include ActionView::Helpers::DateHelper
  
  layout 'email'
  default :from => 'GamePlayDate.com <no-reply@gameplaydate.com>'
  

  def remind_organizer(organizer, event)
    event_time = distance_of_time_in_words_to_now(event.fromtime)
    @organizer = organizer
    mail(:to =>"#{organizer.name} <#{organizer.email}>", :subject => "You have an event in #{event_time}.")
  end
  
  
  def remind_invitee(invitee, event)
    event_time = distance_of_time_in_words_to_now(event.fromtime)
    @invitee = invitee
    mail(:to =>"#{invitee.name} <#{invitee.email}>", :subject => "You have an event in #{event_time}.")
  end
  
end

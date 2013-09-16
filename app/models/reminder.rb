class Reminder < ActiveRecord::Base
  belongs_to :event
  after_create :send_reminder
  
  
  def send_reminder
    if self.event
      ReminderMailer.delay_until(self.send_time).remind_organizer(self.event.organizer, self.event)
     if self.event.users
       self.event.users.each do |invitee|
         ReminderMailer.delay_until(self.send_time).remind_invitee(invitee, self.event)
       end
    end
   end
  end
end

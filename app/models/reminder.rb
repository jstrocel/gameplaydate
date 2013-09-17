class Reminder < ActiveRecord::Base
  belongs_to :event
  before_save :set_time
  after_create :send_reminder
  
  def time_number
    
  end
  
  def time_unit
    
  end
  
  def time_number=(time_number)
    
    @time_number = time_number.to_i
    puts "Time number is " + @time_number.to_s
  end
  
  def time_unit=(time_unit)
    
    @time_unit = time_unit
    puts "Time unit is " + @time_unit
  end
  
  
  def set_time
    
    case @time_unit
    when "minutes"
      self.send_time =self.event.fromtime - @time_number.minutes
    when "hours"
      self.send_time = self.event.fromtime - @time_number.hours
    when "days"
      self.send_time = self.event.fromtime - @time_number.days
    when "weeks"
      self.send_time =self.event.fromtime - @time_number.weeks
    end
  end
  
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

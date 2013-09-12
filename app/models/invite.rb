class Invite < ActiveRecord::Base
  after_create :send_email
  belongs_to :user
  belongs_to :event
  validates_presence_of :user
  validates_uniqueness_of :user_id, :scope => :event_id
  scope :pending,               -> { where(status: "pending") }
  scope :accepted,               -> { where(status: "accepted") }
  scope :cancelled,               -> { where(status: "cancelled") } 
 
  
  def user_name
       self.user 
   end

  def user_name=(name)
      self.user = User.find_by(name: name) if name.present?
  end  
  
  def send_email
    if self.user && self.event
     Notifier.delay.send_invite(self.user, self.event)
   end
  end
  
  
end
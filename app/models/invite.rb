class Invite < ActiveRecord::Base
  attr_accessible :user_name, :user, :event, :user_id, :event_id
  belongs_to :event
  belongs_to :user
  
  scope :pending, where(:accepted => nil)
  validates_uniqueness_of :user_id, :scope => :event_id
  #validate :organizer_cannot_be_invite
  
  def user_name
    user.try(:name)
  end

  def user_name=(name)
    self.user = User.find_by_name(name) if name.present?
  end
  
  def organizer_cannot_be_invite
   if self.user_id == self.event.organizer_id
     errors.add(:user, "can't be the same as organizer")
   end
  end

end

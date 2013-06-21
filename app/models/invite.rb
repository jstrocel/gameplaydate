class Invite < ActiveRecord::Base
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #attr_accessible :followed_id
  belongs_to :user
  belongs_to :event
  #validate :cant_invite_organizer

  #validates :event_id, presence: true
  #validates :user_id, presence: true
  #field  :status, type:String, :default => "pending"
  
  def user_name
       self.user 
   end

  def user_name=(name)
      self.user = User.find_by(name: name) if name.present?
  end  
  
  
  def cant_invite_organizer
    if event
     if self.user == event.organizer
      errors.add(:invite, "An event organizer can't invite themselves")
    end
   end
  end
  
  
end
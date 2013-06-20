class Invite < ActiveRecord::Base
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #attr_accessible :followed_id
  belongs_to :user
  belongs_to :event
  

  #validates :event_id, presence: true
  #validates :user_id, presence: true
  #field  :status, type:String, :default => "pending"
  
  def user_name
       self.user 
   end

  def user_name=(name)
      self.user = User.find_by(name: name) if name.present?
  end  
  
end
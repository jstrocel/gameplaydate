# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User
  #attr_accessible :name, :email, :password, :password_confirmation
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  
  has_many :hosted_events, class_name: "Event", inverse_of: "organizer"
  has_and_belongs_to_many :games
  has_many :personas
  has_many :friendships, foreign_key: "follower_id", dependent: :destroy
  #has_many :followed_users, through: :friendships, source: :followed
  has_many :reverse_friendships, foreign_key: "followed_id",
                                   class_name:  "Friendship",
                                   dependent:   :destroy
  #has_many :followers, through: :reverse_friendships, source: :follower
  
   has_secure_password
     field  :name, type:String
     field   :email, type:String
     field   :admin, type: Boolean 
     field   :password_digest, type:String
     field   :remember_token, type:String
     field   :friend_ids, type: Array, :default => Array.new
     field   :pending_friend_ids, type: Array, :default => Array.new
     before_save { |user| user.email = email.downcase }
      before_save :create_remember_token


      validates :name,  presence: true, length: { maximum: 50 }
      validates :password, length: { minimum: 6 }
      validates :password, presence: true
      validates_confirmation_of :password
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
       validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                           uniqueness: { case_sensitive: false }
  
  
  
  
  /
  
  has_many :events, :foreign_key => "organizer_id"
  has_many :invites, :foreign_key =>"user_id"
  has_many :invitations, :through => :invites, :source => :event
  has_many :games
  has_many :personas
  has_many :friendships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :friendships, source: :followed
  has_many :reverse_friendships, foreign_key: "followed_id",
                                   class_name:  "Friendship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_friendships, source: :follower
 /
                  
  def request_friend(friend)
    friend.pending_friend_ids << self.id unless friend.pending_friend_ids.include?(friend.id) 
  end
  
  def accept_friend(friend)
   if !self.friend_ids.include?(friend.id) 
    self.friend_ids << friend.id 
    friend.friend_ids << self.id
    self.pending_friend_ids.delete(friend.id)
   end
  end
  
  def friends
    User.all_in(friend_ids: self.id)
  end
  
  def remove_friend(friend)
   if self.friend_ids.include?(friend.id) && friend.friend_ids.include?(self.id)
      self.friend_ids.delete(friend.id)
      friend.friend_ids.delete(self.id)
   end
  end
                
  def friend!(friend)   
    if !self.friend_ids.include?(friend.id) && !friend.friend_ids.include?(self.id) && !self.pending_friend_ids.include?(friend.id) && !friend.pending_friend_ids.include?(self.id)
      self.friend_ids << friend.id 
      friend.friend_ids << self.id
    end                   
  end
  
  def invites
    Event.where(:"invites.#{self.id}".exists =>true).all.entries
  end
  
  def all_events
    Event.any_of({ organizer_id: "#{self.id}" },{"invites.#{self.id}"=> false},{"invites.#{self.id}"=> true})
    #(self.events.all + self.invitations.all).uniq
  end
  
  def pending_invites
     Event.where(:"invites.#{self.id}" => false)
  end
  
  def upcoming_events
     (self.events.upcoming + self.invitations.upcoming).uniq
  end
  
  def past_events
     (self.events.past + self.invitations.past).uniq
  end  
  
  def toggle!(field)
    send "#{field}=", !self.send("#{field}?")
    save :validation => false
  end
              
                      
  private                    
  def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
  end
  
#  def admin?
#    if self.role.name = "admin"
#      return true   
#    end  
#  end

  
  
  
  
end

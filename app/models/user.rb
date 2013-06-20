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

class User < ActiveRecord::Base
  
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #include ActiveModel::SecurePassword
  
 
  
   has_secure_password
     
     before_save { |user| user.email = email.downcase }
      before_save :create_remember_token
      has_many :invites, :foreign_key =>"user_id", :dependent => :destroy
      has_many :hosted_events, class_name: "Event", :foreign_key =>"organizer_id"
      has_many :invited_events, class_name: "Event", through: :invites
       has_many :games, through: :personas
       #has_many :personas
       has_many :friendships, foreign_key: "follower_id", dependent: :destroy
       has_many :followed_users, through: :friendships, source: :followed
       has_many :reverse_friendships, foreign_key: "followed_id",
                                        class_name:  "Friendship",
                                        dependent:   :destroy
       has_many :followers, through: :reverse_friendships, source: :follower

      validates :name,  presence: true, length: { maximum: 50 }
      validates :password, length: { minimum: 6 }
      validates :password, presence: true
      validates :password_confirmation, presence: true
      validates_confirmation_of :password
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  
  def events
    Event.joins("LEFT OUTER JOIN invites ON invites.event_id = events.id").where("invites.user_id = #{self.id} OR events.organizer_id = #{self.id}")
  end
  

  


 
  
  def following?(friend)
    friendships.find_by(followed_id: friend.id)
  end
  
  /def friends
    User.all_in(friend_ids: self.id)
  end
  /
  def unfollow!(friend)
    friendships.find_by(followed_id: friend.id).destroy
  end
                
  def follow!(friend)   
   friendships.create!(followed_id: friend.id)          
  end
  
  def all_events
    #Event.any_of({ organizer_id: "#{self.id}" },{"invites.#{self.id}"=> false},{"invites.#{self.id}"=> true})
    #(self.events.all + self.invitations.all).uniq
  end
  
  def pending_invites
    # Event.in(id: invites.where(status:"pending").map(&:event_id))
    Event.joins(:invites).where(:invites => {:user => self, :status => "pending"})
  end
  
  def upcoming_events
     
  end
  
  def past_events
     
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

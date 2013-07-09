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
      before_create { generate_token(:remember_token) }
      has_many :invites, :foreign_key =>"user_id", :dependent => :destroy
      has_many :hosted_events, class_name: "Event", :foreign_key =>"organizer_id", :inverse_of => :organizer
      has_many :invited_events, class_name: "Event", through: :invites
      has_many :gameownerships, class_name: "GameOwnership", dependent: :destroy
       has_many :games, through: :gameownerships
       has_many :personas
       has_many :friendships, foreign_key: "follower_id", dependent: :destroy
       has_many :followed_users, through: :friendships, source: :followed
       has_many :reverse_friendships, foreign_key: "followed_id",
                                        class_name:  "Friendship",
                                        dependent:   :destroy
       has_many :followers, through: :reverse_friendships, source: :follower
       
      validates :name,  presence: true, length: { maximum: 50 }
      validates :password, length: { minimum: 6 }, :on => :create
      validates :password, presence: true, :on => :create
      validates :password_confirmation, presence: true, :on => :create
      validates_confirmation_of :password
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
                        
      #validates_presence_of :beta_invitation_id, :message => 'is required'
      #validates_uniqueness_of :beta_invitation_id

      #has_many :sent_invitations, :class_name => 'BetaInvitation', :foreign_key => 'sender_id'
      #belongs_to :beta_invitation

     # before_create :set_beta_invitation_limit
      
  
      def beta_invitation_token
        beta_invitation.token if beta_invitation
      end

      def beta_invitation_token=(token)
        self.beta_invitation = BetaInvitation.find_by_token(token)
      end
  
  def events
    Event.joins("LEFT OUTER JOIN invites ON invites.event_id = events.id").where("invites.user_id = #{self.id} OR events.organizer_id = #{self.id}")
  end
  
  def friends

  end
  

  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    Notifier.password_reset(self).deliver
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
  
  def claim_game!(game)
   gameownerships.create!(game_id:game.id)
  end
  
  def unclaim_game!(game)
    gameownerships.find_by(game_id:game.id).destroy
   end
  
  def own_game?(game)
   gameownerships.find_by(game_id:game.id)
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
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def set_beta_invitation_limit
    self.beta_invitation_limit = 5
  end
  
#  def admin?
#    if self.role.name = "admin"
#      return true   
#    end  
#  end

  
  
  
  
end

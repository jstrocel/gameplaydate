class Event 
   include Mongoid::Document
   include Mongoid::Timestamps
 
 
  field :maximum_players, type:Integer
  field :fromtime, type: DateTime
  field :totime, type: DateTime
  field :content, type: String
  field :invites, type: Hash, :default => Hash.new
  belongs_to :user
  belongs_to :game
  belongs_to :organizer, class_name: "User", inverse_of: :hosted_events
  validates :fromtime, :totime, :organizer_id, :game_id, :presence => true
  
  /
  
  default_scope order("fromtime DESC")
  #attr_accessible :game_id, :game_name, :fromtime, :totime, :invites_attributes, :game_attributes, :game
  belongs_to :game
  belongs_to :organizer, :class_name => "User"
  has_many :invites, :foreign_key =>"event_id", :dependent => :destroy
  has_many :users, :through => :invites
  
  accepts_nested_attributes_for :invites, :allow_destroy => true, :reject_if => lambda { |a| a[:user_id]==:organizer_id }
  accepts_nested_attributes_for :game
  scope :upcoming, where( ":fromtime >= ?", Time.now)
  scope :past, where( ":totime <= ?", Time.now)
  
  

  def game_name=(name)
    self.game = Game.find_or_create_by_name(name) if name.present?
  end
  
  def invite=(name)
    self.invite= Invite.create(:user_id => User.find_by_name(name).id)
  end
  
  def user=(user)
    self.user= User.find(user.id)
  end
  
  def host
    self.invites.find(:all, :conditions => {:host => true})
  end
  /
  
  def game_name
    game.try(:name)
  end
  
  def invite!(user)
   if user.id != self.organizer_id
     self.invites[user.id] = false
     self.save
   else 
     errors << "An organizer cannot invite himself!"   
   end
  end
  
  def uninvite(user)
  end
  
  def invited?(user)
  end
  
end

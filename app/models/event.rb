class Event 
   include Mongoid::Document
   include Mongoid::Timestamps
   include Mongoid::MultiParameterAttributes
 
  field :maximum_players, type:Integer
  field :fromtime, type: Time
  field :totime, type: Time
  field :content, type: String
  #field :invites, type: Hash, :default => Hash.new
  has_many :invites,:foreign_key =>"event_id", :dependent => :destroy
  accepts_nested_attributes_for :invites, :allow_destroy => true
 
  belongs_to :game
  validates :fromtime, :totime, :game_id, :presence => true
  
  def organizer
    self.invites.in(status:"organizer").first
  end
  
  def game_name
    game.try(:name)
  end
  
  def game_name=(name)
    self.game = Game.find_or_create_by(name: name) if name.present?
  end
  
  def invite!(user)
   self.invites.create!(user_id: user.id, status:"pending")
  end
  
  def uninvite(user)
  end
  
  def invited?(user)
  end
  
end

class Event < ActiveRecord::Base
   #include Mongoid::Document
   #include Mongoid::Timestamps
   #include Mongoid::MultiParameterAttributes
 
  #field :maximum_players, type:Integer
  #field :fromtime, type: Time
  #field :totime, type: Time
  #field :content, type: String
  #field :invites, type: Hash, :default => Hash.new
  has_many :invites,:foreign_key =>"event_id", :dependent => :destroy
  has_many :users, :through => :invites
  accepts_nested_attributes_for :invites, :allow_destroy => true
  belongs_to :organizer
  belongs_to :game
  validates :fromtime, :totime, :game_id, :presence => true
  #validate :presence_of_organizer, :on => :create
  validate :cant_invite_organizer_to_event
  
  
  def game_name
    game.try(:name)
  end
  
  def game_name=(name)
    self.game = Game.find_or_create_by(name: name) if name.present?
  end
  
  def invite!(user)
   self.invites.create!(user_id: user.id, status:"pending")
  end
  
  def organize!(user)
    self.invites.create!(user_id: user.id, status:"organizer")
  end
  
  def uninvite(user)
  end
  
  def invited?(user)
  end
  
  def cant_invite_organizer_to_event
    self.invites.each do |invite|
     if invite.user == self.organizer
      errors.add(:organizer, "cannot be invited")
     end
    end
  end
  

  
end

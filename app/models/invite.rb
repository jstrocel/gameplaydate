class Invite < ActiveRecord::Base
  attr_accessible :game_id, :game_name, :fromtime, :totime, :invitees_attributes, :game_attributes
  belongs_to :game
  belongs_to :user
  has_many :invitees, :dependent => :destroy
  validates :invitees, :presence => true
  validates :game_id, :user_id, :fromtime, :totime, :presence => true
  accepts_nested_attributes_for :invitees,  :allow_destroy => true 
  accepts_nested_attributes_for :game
  
  def game_name
    game.try(:name)
  end

  def game_name=(name)
    self.game = Game.find_or_create_by_name(name) if name.present?
  end
  
  def invite!(user)
  end
  
  def uninvite(user)
  end
  
  def invited?(user)
  end
  
end

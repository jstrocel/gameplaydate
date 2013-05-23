class Invite < ActiveRecord::Base
  attr_accessible :game_id, :game_name, :fromtime, :totime, :invitees_attributes, :game_attributes, :game
  belongs_to :game
  belongs_to :organizer, :class_name => "User"
  has_many :invitees, :foreign_key =>"invite_id", :dependent => :destroy
  has_many :users, :through => :invitees
  validates :fromtime, :totime, :organizer_id, :game_id, :presence => true
  accepts_nested_attributes_for :invitees,  :allow_destroy => true 
  accepts_nested_attributes_for :game
  
  def game_name
    game.try(:name)
  end

  def game_name=(name)
    self.game = Game.find_or_create_by_name(name) if name.present?
  end
  
  def invitee=(name)
    self.invitee= Invitee.create(:user_id => User.find_by_name(name).id)
  end
  
  def user=(user)
    self.user= User.find(user.id)
  end
  
  def host
    self.invitees.find(:all, :conditions => {:host => true})
  end
  
  def invite!(user)
    self.invitees.create!(user_id:user.id)
  end
  
  def uninvite(user)
  end
  
  def invited?(user)
  end
  
end

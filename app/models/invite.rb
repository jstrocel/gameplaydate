class Invite < ActiveRecord::Base
  has_one :game
  has_many :invitees, :dependent => :destroy
  accepts_nested_attributes_for :invitees, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true 
  accepts_nested_attributes_for :game
end

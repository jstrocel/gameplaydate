class GameOwnership < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  
  validates :game_id, presence: true
   validates :user_id, presence: true
end

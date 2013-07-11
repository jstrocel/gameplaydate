class Persona < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  validates :name,  presence: true, length: { maximum: 50 }
  validates :game_id, :user_id, presence: true
end

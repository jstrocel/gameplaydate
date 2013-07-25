class Game < ActiveRecord::Base
  has_many :events
  has_many :personas
  has_many :gameownerships, class_name: "GameOwnership"
  has_many :users, through: :gameownerships
end

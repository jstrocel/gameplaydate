class Game < ActiveRecord::Base
  #include Mongoid::Document
  #field :name, type: String
  #field :platform, type: String
  has_many :events
  #has_many :personas
  has_many :gameownerships, class_name: "GameOwnership"
  has_many :users, through: :gameownerships
end

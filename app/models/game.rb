class Game 
  include Mongoid::Document
  field :name, type: String
  field :platform, type: String
  has_many :events
  has_and_belongs_to_many :users
end

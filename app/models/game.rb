class Game < ActiveRecord::Base
  #include Mongoid::Document
  #field :name, type: String
  #field :platform, type: String
  has_many :events
  #has_many :personas
end

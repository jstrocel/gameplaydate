# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_one :role
  has_many :invites
  has_many :attendances
  has_many :games
  has_many :personas
  has_many :friendships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_friendships, foreign_key: "followed_id",
                                   class_name:  "Friendship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_friendships, source: :follower
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  
  validates :name,  presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
  def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
  end
  
end

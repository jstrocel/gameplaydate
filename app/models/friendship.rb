class Friendship 
  include Mongoid::Document
  include Mongoid::Timestamps
  #attr_accessible :followed_id

  belongs_to :follower, class_name: "User", inverse_of: :friendship
  belongs_to :followed, class_name: "User", inverse_of: :reverse_friendship

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  field  :status, type:String
end

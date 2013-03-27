class Invitee < ActiveRecord::Base
  attr_accessible :user_id, :invite_id, :user_name, :user
  belongs_to :invite
  belongs_to :user
  
  def user_name
    user.try(:name)
  end

  def user_name=(name)
    self.user = User.find_by_name(name) if name.present?
  end
end

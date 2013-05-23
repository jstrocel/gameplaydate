class Invite < ActiveRecord::Base
  attr_accessible :user_id, :event_id, :user_name, :user, :event
  belongs_to :event
  belongs_to :user
  
  def user_name
    user.try(:name)
  end

  def user_name=(name)
    self.user = User.find_by_name(name) if name.present?
  end
end

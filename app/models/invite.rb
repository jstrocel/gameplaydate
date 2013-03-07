class Invite < ActiveRecord::Base
  has_many :invitees
end

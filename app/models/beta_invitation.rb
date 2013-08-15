class BetaInvitation < ActiveRecord::Base
  #after_create :send_email
  belongs_to :sender, :class_name => 'User', inverse_of: :sent_beta_invitations
  has_one :recipient, :class_name => 'User', :foreign_key => 'beta_invitation_id'

  validates_presence_of :recipient_email
  validate :recipient_is_not_registered
  validate :sender_has_invitations, :if => :sender

  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender
  
  
  
  private

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  end
  


  def sender_has_invitations
    #debugger
    unless sender.beta_invitation_limit > 0 or sender.role == "admin"
      errors.add_to_base 'You have reached your limit of invitations to send.'
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def decrement_sender_count
    sender.decrement! :beta_invitation_limit
  end
end

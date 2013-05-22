module InviteeHelper
  def invitee_new(user_id, options = {})
    FactoryGirl.create(:invitee, options.merge(:user_id => user_id))
  end
end

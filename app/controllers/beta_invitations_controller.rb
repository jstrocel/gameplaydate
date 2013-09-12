class BetaInvitationsController < ApplicationController
  before_filter :signed_in_user
  
  def index
   @beta_invitations = BetaInvitation.paginate(page: params[:page])
  end
  
  def new
    @beta_invitation = BetaInvitation.new()
  end

  def create
    @beta_invitation = BetaInvitation.new(beta_invite_params)
    @beta_invitation.sender = current_user
    if @beta_invitation.save
      track_activity @beta_invitation
      Notifier.delay.send_beta_invite(@beta_invitation, beta_signup_url(@beta_invitation.token))
      redirect_to new_beta_invitation_url, :notice => "Successfully created beta invitation."
    else
      render :new
    end
  end
  private


    def beta_invite_params
      allowed_attributes = [:sender_id, :recipient_email, :token, :sent_at]
      params.require(:beta_invitation).permit(allowed_attributes)
    end
  
end

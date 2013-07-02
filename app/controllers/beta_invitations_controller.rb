class BetaInvitationsController < ApplicationController
  def new
    @beta_invitation = BetaInvitation.new
  end

  def create
    @beta_invitation = BetaInvitation.new(params[:beta_invitation])
    if @beta_invitation.save
      redirect_to root_url, :notice => "Successfully created beta invitation."
    else
      render :action => 'new'
    end
  end
  private


    def event_params
      allowed_attributes = [:sender_id, :recipient_email, :token, :sent_at]
      params.require(:beta_invitation).permit(allowed_attributes)
    end
  
end

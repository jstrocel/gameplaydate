class InvitesController < ApplicationController
  before_action :signed_in_user
  
  def accept
      @invite = Invite.find_by(id: params[:id])
      @invite.update_attributes(:status => 'accepted')
      Notifier.accept_email(@invite).deliver
        flash[:success] = "Invite Accepted"
        respond_to do |format|
          format.html { redirect_to :back }
          format.js
        end
  end
  
  def cancel
       @invite = Invite.find_by(id: params[:id])
        @invite.update_attributes(:status => 'cancelled')
        Notifier.cancel_email(@invite).deliver
          flash[:success] = "Invite Cancelled"
          respond_to do |format|
            format.html { redirect_to :back }
            format.js
          end
  end
  
end

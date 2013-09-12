class InvitesController < ApplicationController
  before_action :signed_in_user
  
  def accept
      @invite = Invite.find_by(id: params[:id])
      if @invite.update_attributes(:status => 'accepted')
      Notifier.delay.accept_email(@invite)
        flash[:success] = "Invite Accepted"
        respond_to do |format|
          format.html { redirect_to :back }
          format.js
        end
      else
        render @invite.event
      end
  end
  
  def cancel
       @invite = Invite.find_by(id: params[:id])
        @invite.update_attributes(:status => 'cancelled')
        Notifier.delay.cancel_email(@invite)
          flash[:success] = "Invite Cancelled"
          respond_to do |format|
            format.html { redirect_to :back }
            format.js
          end
  end
  
end

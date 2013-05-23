class InvitesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  
  def index
    @invites = current_user.invites.all
  end

  def show
     @invite = Invite.find(params[:id])
  end

  def new
    @invite = Invite.new()
    invitee = @invite.invitees.build
    
  end

  def create
    @invite = current_user.invites.build(params[:invite])
      if @invite.save
        flash[:success] = "Event Created!"
        redirect_to @invite
      else
        render :new
      end
  end

  def update
  end
  
  def cancel
    
  end
  

  def destroy
    @invite = Invite.find(params[:id]).destroy
  end
end

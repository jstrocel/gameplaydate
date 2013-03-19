class InvitesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  
  def index
    @invites = current_user.invites.all
    @invite = current_user.invites.build
     3.times do
            invitee = @invite.invitees.build
          end
   # @invite.invitee = Invitee.new
  end

  def show
     @invite = Invite.find(params[:id])
  end

  def new
    @invite = Invite.new()
    3.times do
          invitee = @invite.invitees.build
        end
  end

  def create
    @invite = current_user.invites.build(params[:invite])
      if @invite.save
        flash[:success] = "User invited!"
        redirect_to invites_path
      else
        redirect_to invites_path
      end
  end

  def update
  end

  def destroy
    @invite = Invite.find(params[:id]).destroy
  end
end

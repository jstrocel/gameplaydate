class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @events = current_user.events
      @pending_events = current_user.pending_invites
      
    end
  end

  def help
  end
end

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @events = current_user.events
      @pending_events = current_user.pending_invites
      @confirmed_events = current_user.confirmed_events
      
    end
  end

  def help
  end
end

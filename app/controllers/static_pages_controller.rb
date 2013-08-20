class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @events = current_user.events
      @hosted_events = current_user.hosted_events
      @pending_events = current_user.pending_invites.limit(5)
      @confirmed_events = current_user.confirmed_events.limit(5)
      
    end
  end

  def help
  end
end

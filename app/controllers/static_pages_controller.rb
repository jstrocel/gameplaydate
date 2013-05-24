class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @pending  = current_user.pending_invites
      @upcoming = current_user.upcoming_events
    end
  end

  def help
  end
end

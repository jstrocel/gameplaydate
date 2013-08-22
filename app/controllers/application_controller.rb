class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end
  
  def current_permission
      @current_permission ||= Permission.new(current_user)
    end

    def authorize
      if !current_permission.allow?(params[:controller], params[:action])
        redirect_to root_url, alert: "Not authorized"
      end
    end
end

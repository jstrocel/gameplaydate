class ActivityPresenter < SimpleDelegator
  attr_reader :activity
  
  def initialize(activity, view)
    super(view)
    @activity = activity
  end
  
  def render_activity
    div_for activity do
      if activity.user
        link_to(activity.user.name, activity.user) + " " + render_partial+" "+activity.created_at
      else
        link_to(activity.trackable.name, activity.trackable) + " joined Gameplaydate.com! " +activity.created_at
      end
    end
  end
  
  def render_partial
    locals = {activity: activity, presenter: self}
    locals[activity.trackable_type.underscore.to_sym] = activity.trackable
    render partial_path, locals
  end
  
  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end
  
  def partial_paths
    [
      "activities/#{activity.trackable_type.underscore}/#{activity.action}",
      "activities/#{activity.trackable_type.underscore}",
      "activities/activity"
    ]
  end
end
class Permission
  def initialize(user)
    allow :users, [:new, :create]
    allow :static_pages, [:home, :help]
    allow :sessions, [:new, :create, :destroy]
    if user
      allow :static_pages, [:home, :help]
      allow :events, [:index, :show, :new, :create]
      allow :events, [:edit, :update, :destroy] do |event|
        event.organizer_id == user.id
      end
      allow :games, :all
      allow :users, [:index, :show]
      allow :users, [:edit, :update, :destroy] do |affected_user|
        affected_user.id == user.id
      end
      allow_all if user.admin?
    end
  end
  
  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
  
  def allow_all
    @allow_all = true
  end
  
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow_param(resources, attributes)
    @allowed_params ||= {}
    Array(resources).each do |resource|
      @allowed_params[resource] ||= []
      @allowed_params[resource] += Array(attributes)
    end
  end

  def allow_param?(resource, attribute)
    if @allow_all
      true
    elsif @allowed_params && @allowed_params[resource]
      @allowed_params[resource].include? attribute
    end
  end

  def permit_params!(params)
    if @allow_all
      params.permit!
    elsif @allowed_params
      @allowed_params.each do |resource, attributes|
        if params[resource].respond_to? :permit
          params[resource] = params[resource].permit(*attributes)
        end
      end
    end
  end
end

class EventsController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @events = Event.paginate(page: params[:page], :per_page => 10)
  end

  def show
     @event = Event.find(params[:id])
     @users = @event.users
     @organizer = User.find(@event.organizer_id)
  end
  
  def pending
    @events = current_user.pending_invites.paginate(page: params[:page])
  end
  
  def confirmed
    @events = current_user.confirmed_events.paginate(page: params[:page])
  end
  

  def new
    @event = current_user.hosted_events.new()
    @games = current_user.games
    @friends = current_user.followers
    invite = @event.invites.build    
  end

  def create
    @games = current_user.games
    @event = current_user.hosted_events.build(event_params)
    @friends = current_user.followers
      if @event.save
        flash[:success] = "Event Created!"
        redirect_to @event
      else
        render :new
      end
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    if @event.update_attributes(event_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  def cancel
    
  end
  

  def destroy
    @event = Event.find(params[:id]).destroy
    flash[:success] = "Event destroyed."
    redirect_to events_url
  end
  
  
  private

    def load_event
      @event = Event.find(params[:id])
    end

    def event_params
      allowed_attributes = [ :organizer, :game_name, :game, :game_id, :maximum_players, :fromtime, 
        :"fromtime(1i)", :"fromtime(2i)", :"fromtime(3i)", :"fromtime(4i)", :"fromtime(5i)", :"totime(1i)", 
        :"totime(2i)", :"totime(3i)", :"totime(4i)", :"totime(5i)", :totime, :content, 
        invites_attributes: [:user_id, :user, :status]]
      params.require(:event).permit(allowed_attributes)
    end
  
  
  
end

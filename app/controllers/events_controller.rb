class EventsController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @events = Event.paginate(page: params[:page], :per_page => 10)
  end
  
  def my_events
    @events = current_user.events.paginate(page: params[:page], :per_page => 10)
  end

  def show
     @event = Event.find(params[:id])
     @users = @event.users
     @organizer = User.find(@event.organizer_id)
  end
  
  def hosted
    @events = current_user.hosted_events.paginate(page: params[:page])
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
    @invite = @event.invites.new()
    @reminder = @event.reminders.new()
  end

  def create
    @games = current_user.games
    @event = current_user.hosted_events.build(event_params)
    @friends = current_user.followers
      if @event.save
        track_activity @event
        flash[:success] = "Event Created!"
        redirect_to @event
      else
        render :new
      end
  end
  
  def edit
    @event = Event.find(params[:id])
     @games = current_user.games
      @friends = current_user.followers
  end

  def update
    @event = Event.find(params[:id])
    @games = current_user.games
      @friends = current_user.followers
       
    if @event.update_attributes(event_params)
      track_activity @event
      flash[:success] = "Event updated"
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
        invites_attributes: [:id, :user_id, :user, :status, :_destroy, :event_id, :event],
        reminders_attributes: [:id, :event_id, :_destroy, :event, :time_number, :time_unit]]
      params.require(:event).permit(allowed_attributes)
    end
  
  
  
end

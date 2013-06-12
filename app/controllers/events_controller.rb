class EventsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  
  def index
    @events = current_user.all_events
  end

  def show
     @event = Event.find(params[:id])
  end

  def new
    @event = Event.new()
  end

  def create
    @event = current_user.hosted_events.build(event_params)
      if @event.save
        flash[:success] = "Event Created!"
        redirect_to @event
      else
        render :new
      end
  end

  def update
  end
  
  def cancel
    
  end
  

  def destroy
    @event = Event.find(params[:id]).destroy
  end
  
  
  private

    def load_event
      @event = Episode.find(params[:id])
    end

    def event_params
      allowed_attributes = [ :game_name, :game, :maximum_players, :fromtime, :"fromtime(1i)", :"fromtime(2i)", :"fromtime(3i)", :"fromtime(4i)", :"fromtime(5i)", :"totime(1i)", :"totime(2i)", :"totime(3i)", :"totime(4i)", :"totime(5i)", :totime, :content]
      params.require(:event).permit(allowed_attributes)
    end
  
  
  
end

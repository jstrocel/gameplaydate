class EventsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  
  def index
    @events = current_user.events.all
  end

  def show
     @event = Event.find(params[:id])
  end

  def new
    @event = Event.new()
    invite = @event.invites.build
  end

  def create
    @event = current_user.events.build(params[:event])
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
end

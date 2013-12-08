class EventsController < ApplicationController
  def index
    @events = Event.all
    @event = Event.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      redirect_to root_url
    end
  end

  def show
    id = params[:id]
    @event = Event.find(id)
    @event.get_photos
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 
  def event_params
    params.require(:event).permit(:tag, :start_time, :end_time)
  end
end

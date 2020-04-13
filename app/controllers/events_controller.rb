class EventsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]

  def index
    @events = Event.all
    @upcoming_events = @events.upcoming
    @previous_events = @events.past
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to events_path
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :description)
  end
end

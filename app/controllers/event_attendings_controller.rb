class EventAttendingsController < ApplicationController
  before_action :logged_in_user, only: :create
  
  def create
    @event = Event.find(params[:id])
    if current_user.attended_events.include?(@event)
      flash[:danger] = "You are already attending this event."
    else
      if current_user.attended_events << @event
        flash[:success] = "Joined #{@event.title}!"
        redirect_to @event
      else
        flash[:danger] = "An error occured"
        redirect_to @event
    end
  end

end

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :attending_or_hosting
  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end
  
  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in to create events"
      redirect_to login_path
    end
  end

  def log_in(user)
    session[:id] = user.id
  end

  def attending_or_hosting(event)
    event.attendees.include?(current_user) || event.creator == current_user
  end
end

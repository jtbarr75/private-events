class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user
      log_in(@user)
      flash[:success] = "Logged in"
      redirect_to root_url
    else
      flash.now[:now] = 'Account not found.'
      render 'new'
    end
  end

  def destroy
    session[:id] = nil
    flash[:success] = "Logged out"
    redirect_to root_url
  end

  private 
end

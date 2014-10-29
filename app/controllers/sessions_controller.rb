class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password]) && user.admin == false
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome, #{user.firstname}!"
    elsif user && user.authenticate(params[:password]) && user.admin == true
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome, Admin!"
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end

end

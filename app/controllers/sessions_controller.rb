class SessionsController < ApplicationController
  # /login sessions#new
  def new
  end

  def create
    # find the user by email and store the value in user
    # [:session][:email] - to access the email value nested inside the session form parameters
    user = User.find_by_email(params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in"
    else
      flash.now[:alert] = "Credential invalid"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end

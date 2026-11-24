class UsersController < ApplicationController
  before_action :authenticate_user, only: [ :show ]

  # create an empty User object so the Sign Up form can use it
  def new
    @user = User.new
  end

  def create
    # build a new user object
    @user = User.new(user_params)

    # if it insert the user into db
    # before saving rails check model validation
    # everything passes .save returns true otherwise false
    if @user.save
      # this automatically logged in new user
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully"
    else
      render :new, status: :unprocessable_content
    end
  end

  def show
    @user = User.find(params[:id])
    # unless the user is current user redirect it to root path
    # authorization
    redirect_to root_path, alert: "You can only access your own profile" unless @user == current_user
  end


  private
  # expect - combines 2 operation:
  # it checks expected parameter structure and permits only listed attributes
  def user_params
    params.expect(user: [
      :name,
      :email,
      :password,
      :password_confirmation
    ])
  end
end

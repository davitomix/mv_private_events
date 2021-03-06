class UsersController < ApplicationController
  before_action :current_user
  before_action :logged_in_user, only: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to the Sample App!'
      self.current_user = @user
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @events = @user.attended_events
    @previous = @user.attended_events.previous
    @upcoming = @user.attended_events.upcoming
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end
end

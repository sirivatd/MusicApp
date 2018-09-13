class UsersController < ApplicationController
  def index
    render :new
  end

  def create
    @new_user = User.new(user_params)

    if @new_user.save!
      login_user!(@new_user)
      redirect_to user_url(@new_user)
    else
      flash.now[:errors] = @new_user.errors.full_messages
      render :new
    end
  end

  def new
    @new_user = User.new
    render :new
  end

  def show
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

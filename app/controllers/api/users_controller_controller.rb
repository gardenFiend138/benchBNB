class Api::UsersControllerController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :show
    else
      flash[:errors] = @user.errors.full_messages
      render :show
    end
  end

  def new
    render :show
  end
  def show
    render :show
  end
  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end

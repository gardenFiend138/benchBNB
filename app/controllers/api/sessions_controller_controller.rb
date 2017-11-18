class Api::SessionsControllerController < ApplicationController

  def create
    user = User.find_by_cred(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      login(user)
      render :new
    else
      flash[:errors] = user.errors.full_messages
      render :login
    end
  end

  def destroy
    logout
    render :login
  end

end

class UserSessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password])
      redirect_back_or_to(root_path, notice: "Welcome #{@user.email}")
    else
      @user = User.new
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end
end
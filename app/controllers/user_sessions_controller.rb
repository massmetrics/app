class UserSessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password])
      redirect_back_or_to(root_path, success: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end

  private
  def allowed_params
    params.require(:user).permit(:email, :password)
  end
end
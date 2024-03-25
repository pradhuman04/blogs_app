class UsersController < ApplicationController

  def new
    redirect_to blogs_path if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.password == params[:user][:password_confirmation]
      if @user.save
        session[:user_id] = @user.id
        redirect_to blogs_path, notice: 'User was successfully created!'
      else
        render :new
      end
    else
      @user.errors.add(:password_confirmation, "doesn't match Password")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

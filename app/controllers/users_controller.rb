class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def new
    redirect_to root_url if current_user.present?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.valid?
        @user.save!
        format.html { redirect_to root_path }
      else
        format.html { render :new }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :require_login
  def edit
    @user = current_user
  end

  def update
    @user=current_user
    if @user.valid_password?(params[:user][:actual_password]) && @user.update(user_params)
      redirect_to root_path, notice: "Heslo bolo úspešne zmenené"
    else
      @user.errors.add(:actual_password, "nie je správne") if @user.errors.empty?
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit( :password_confirmation, :password)
  end
end
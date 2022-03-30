class UsersController < ApplicationController
  before_action :check_authorization

  def new
    @user = User.new
  end

  def create

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def check_authorization
    redirect_to root_path, notice: 'Unauthorized' unless is_admin?
  end
end

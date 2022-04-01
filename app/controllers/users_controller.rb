class UsersController < ApplicationController
  before_action :check_authorization

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation_notification!

    respond_to do |format|
      if @user.save
        UserMailer.with(user: @user).new_user_email.deliver_later
        format.html { redirect_to users_dashboard_index_path, notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def check_authorization
    redirect_to root_path, notice: 'Unauthorized' unless is_admin?
  end
end

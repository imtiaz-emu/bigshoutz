class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ show ]
  before_action :set_profile
  before_action :editing_others_profile?, only: %i[edit]

  def show
    @listings = @profile.user.listings
  end

  def edit; end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    respond_to do |format|
      if @user.update_with_password(user_params)
        bypass_sign_in(@user)
        format.html { redirect_to @profile, notice: 'Password was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
    @user = @profile&.user
  end

  def prepare_params
    @profile_params[:gender] = @profile_params[:gender]&.to_i
    @profile_params
  end

  def profile_params
    if @profile_params.present?
      @profile_params
    else
      @profile_params = params.require(:profile).permit(:first_name, :last_name, :photo, :about_me,
                                    :mobile_no, :date_of_birth, :gender, :fb_link, :twitter_link, :insta_link)
      prepare_params
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  # user can edit only his profile. Admin can edit other's profile.
  def editing_others_profile?
    return if is_admin?

    if current_user.profile != @profile
      redirect_to edit_profile_path(current_user.profile)
    end
  end
end
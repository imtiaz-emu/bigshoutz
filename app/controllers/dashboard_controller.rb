class DashboardController < ApplicationController
  before_action :check_authorization, only: %i[users services]

  def index; end

  def listings
    @listings = is_admin? ? Listing.all : current_user.listings
  end

  def users
    @users = User.includes(:profile, :roles).all
  end

  def services
    @services = Service.all
  end

  def addons
    @addons = Addon.all
  end

  private

  def check_authorization
    redirect_to root_path, notice: 'Unauthorized' unless is_admin?
  end
end

class DashboardController < ApplicationController

  def index; end

  def listings
    @listings = current_user.listings
  end
end

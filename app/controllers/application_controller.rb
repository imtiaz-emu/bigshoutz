class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper

  layout :fetch_layout

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def after_sign_in_path_for (resource)
    stored_location_for(resource) || dashboard_index_path
  end

  def incomplete_profile?
    current_profile.first_name.nil? || current_profile.last_name.nil?
  end

  def render_404
    render template: 'shared/404', layout: 'error_404', status: 404
  end

  def fetch_layout
    if devise_controller? || params[:controller] == 'home'
      'application'
    else
      'dashboard'
    end
  end

  def full_error_messages(object)
    object.errors.full_messages.to_sentence
  end
end

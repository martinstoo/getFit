class ApplicationController < ActionController::Base
  before_action :authenticate_benutzer!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
  def record_not_found
    flash[:alert] = ‘Record not found.’
    redirect_to root_path
  end
end
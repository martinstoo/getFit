class ApplicationController < ActionController::Base
  before_action :authenticate_benutzer!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  after_action :log_activity
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
  def log_activity
    if benutzer_signed_in? && !session[:logged_in]
      current_benutzer.log_activity("User signed in", "User ID: #{current_benutzer.id}")
      session[:logged_in] = true
    elsif benutzer_signed_in? && session[:logged_in]
      # other actions
    end
  end
  def record_not_found
    flash[:alert] = 'Record not found.'
    redirect_to root_path
  end
end
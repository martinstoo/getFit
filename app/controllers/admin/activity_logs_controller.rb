class Admin::ActivityLogsController < ApplicationController
  before_action :authenticate_benutzer!
  before_action :authorize_admin!

  def index
    @activity_logs = ActivityLog.includes(:benutzer).order(created_at: :desc)
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_benutzer.admin?
  end
end

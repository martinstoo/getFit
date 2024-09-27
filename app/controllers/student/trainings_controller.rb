module Student
  class TrainingsController < ApplicationController
    before_action :authenticate_benutzer!
    before_action :require_student
    def index
      @trainings = Training.all
    end
    def show
      
  @training = Training.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to student_trainings_path, alert: 'Training not found.'
      Rails.logger.info "Training nicht gefunden"
    end
    
    private

    def require_student
      unless current_benutzer.student?
        redirect_to root_path, alert: 'Access Denied.'
        Rails.logger.info "Sie haben keinen Zugriff"
      end
    end
  end
end

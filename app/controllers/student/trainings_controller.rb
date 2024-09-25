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
    end
    
    private

    def require_student
      unless current_benutzer.student?
        redirect_to root_path, alert: 'Access Denied.'
      end
    end
  end
end

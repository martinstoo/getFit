module Coach
  class TrainingsController < ApplicationController
    before_action :authenticate_benutzer!
    before_action :require_coach 
    before_action :set_training, only: %i[show edit update destroy]

    def index
      @trainings = current_benutzer.trainings
    end

    def show
    end

    def new
      @training = current_benutzer.trainings.build
    end

    def create
      @training = current_benutzer.trainings.build(training_params)
      if @training.save
        current_benutzer.log_activity("Training Created", "Title: #{@training.title}")  # Log the activity
        Rails.logger.info "Neues Training wurde erstellt"
        redirect_to coach_trainings_path, notice: 'Training was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @training.update(training_params)
        current_benutzer.log_activity("Training Updated", "Title: #{@training.title}")  # Log the activity
        Rails.logger.info "Training wurde aktualisiert"
        redirect_to coach_trainings_path, notice: 'Training was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      current_benutzer.log_activity("Training Deleted", "Title: #{@training.title}")  # Log the activity
      @training.destroy
      Rails.logger.info "Training wurde gelöscht"
      redirect_to coach_trainings_path, notice: 'Training was successfully destroyed.'
    end

    private

    def require_coach
      unless current_benutzer.coach? || current_benutzer.admin?
        Rails.logger.info "Sie haben keinen Zugriff"
        redirect_to root_path, alert: 'Access Denied.'
      end
    end

    def set_training
      @training = current_benutzer.trainings.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info "Training nicht gefunden"
      redirect_to coach_trainings_path, alert: 'Training not found.'
    end

    def training_params
      params.require(:training).permit(:title, :description)
    end
  end
end

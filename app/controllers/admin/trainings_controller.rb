module Admin
  class TrainingsController < ApplicationController
    before_action :authenticate_benutzer!
    before_action :authorize_admin!
    before_action :set_training, only: %i[show edit update destroy]

    def index
      @trainings = Training.all  # Fetch all trainings for admin
    end

    def show
    end

    def new
      @training = Training.new
    end

    def create
      @training = Training.new(training_params)
      if @training.save
        current_benutzer.log_activity("Training Created", "Title: #{@training.title}")  
        Rails.logger.info "Neues Training wurde erstellt"
        redirect_to admin_trainings_path, notice: 'Training was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @training.update(training_params)
        current_benutzer.log_activity("Training Updated", "Title: #{@training.title}")
        Rails.logger.info "Training wurde aktualisiert"
        redirect_to admin_trainings_path, notice: 'Training was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      current_benutzer.log_activity("Training Deleted", "Title: #{@training.title}")
      @training.destroy
      Rails.logger.info "Training wurde gelöscht"
      redirect_to admin_trainings_path, notice: 'Training was successfully destroyed.'
    end

    private

    def authorize_admin!
      redirect_to root_path, alert: "You are not authorized to access this page." unless current_benutzer.admin?
    end

    def set_training
      @training = Training.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info "Training nicht gefunden"
      redirect_to admin_trainings_path, alert: 'Training not found.'
    end

    def training_params
      params.require(:training).permit(:title, :description)
    end
  end
end

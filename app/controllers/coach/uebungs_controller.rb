module Coach
  class UebungsController < ApplicationController
    before_action :authenticate_benutzer!
    before_action :require_coach 
    before_action :set_uebung, only: %i[show edit update destroy]

    def index
      @uebungs = current_benutzer.uebungs
    end

    def show
    end

    def new
      @uebung = current_benutzer.uebungs.build
    end

    def create
      @uebung = current_benutzer.uebungs.build(uebung_params)
      if @uebung.save
        current_benutzer.log_activity("Übung Created", "Title: #{@uebung.title}")  # Log the activity
        Rails.logger.info "Neues Übung wurde erstellt"
        redirect_to coach_uebungs_path, notice: 'Uebung was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @uebung.update(uebung_params)
        current_benutzer.log_activity("Übung Updated", "Title: #{@uebung.title}")  # Log the activity
        Rails.logger.info "Übung wurde aktualisiert"
        redirect_to coach_uebungs_path, notice: 'Uebung was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      current_benutzer.log_activity("Übung Deleted", "Title: #{@uebung.title}")  # Log the activity
      @uebung.destroy
      Rails.logger.info "Übung wurde gelöscht"
      redirect_to coach_uebungs_path, notice: 'Übung was successfully destroyed.'
    end

    private

    def require_coach
      unless current_benutzer.coach? || current_benutzer.admin?
        Rails.logger.info "Sie haben keinen Zugriff"
        redirect_to root_path, alert: 'Access Denied.'
      end
    end

    def set_uebung
      @uebung = current_benutzer.uebungs.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info "Übung nicht gefunden"
      redirect_to coach_uebungs_path, alert: 'Übung not found.'
    end

    def uebung_params
      params.require(:uebung).permit(:title, :description)
    end
  end
end

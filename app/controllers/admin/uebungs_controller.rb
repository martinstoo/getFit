module Admin
  class UebungsController < ApplicationController
    before_action :authenticate_benutzer!
    before_action :authorize_admin!
    before_action :set_uebung, only: %i[show edit update destroy]

    def index
      @uebungs = Uebung.all  # Fetch all exercises for admin
    end

    def show
    end

    def new
      @uebung = Uebung.new
    end

    def create
      @uebung = Uebung.new(uebung_params)
      if @uebung.save
        current_benutzer.log_activity("Übung Created", "Title: #{@uebung.title}")  # Log the activity
        Rails.logger.info "Neues Übung wurde erstellt"
        redirect_to admin_uebungs_path, notice: 'Übung was successfully created.'
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
        redirect_to admin_uebungs_path, notice: 'Übung was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      current_benutzer.log_activity("Übung Deleted", "Title: #{@uebung.title}")  # Log the activity
      @uebung.destroy
      Rails.logger.info "Übung wurde gelöscht"
      redirect_to admin_uebungs_path, notice: 'Übung was successfully destroyed.'
    end

    private

    def authorize_admin!
      redirect_to root_path, alert: "You are not authorized to access this page." unless current_benutzer.admin?
    end

    def set_uebung
      @uebung = Uebung.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info "Übung nicht gefunden"
      redirect_to admin_uebungs_path, alert: 'Übung not found.'
    end

    def uebung_params
      params.require(:uebung).permit(:title, :description)
    end
  end
end

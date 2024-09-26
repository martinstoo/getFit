module Coach
  class UebungsController < ApplicationController
    before_action :authenticate_benutzer!
    before_action :require_coach
    before_action :set_uebung, only: %i[show edit update destroy]
    def index
      @uebungs = current_benutzer.uebungs
    end

    def show
      @uebung = Uebung.find(params[:id])
    end

    def new
      @uebung = current_benutzer.uebungs.build
    end

    def create
      @uebung = current_benutzer.uebungs.build(uebung_params)
      if @uebung.save
        redirect_to coach_uebungs_path, notice: 'Uebung was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @uebung.update(uebung_params)
        redirect_to coach_uebungs_path, notice: 'Uebung was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @uebung.destroy
      redirect_to coach_uebungs_path, notice: 'Uebung was successfully destroyed.'
    end

    private

    def require_coach
      unless current_benutzer.coach?
        redirect_to root_path, alert: 'Access Denied.'
      end
    end

    def set_uebung
      @uebung = current_benutzer.uebungs.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to coach_uebungs_path, alert: 'Uebung not found.'
    end

    def uebung_params
      params.require(:uebung).permit(:title, :description)
    end
  end
end

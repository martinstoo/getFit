class HomeController < ApplicationController
  before_action :authenticate_benutzer!
  def index
  end
end

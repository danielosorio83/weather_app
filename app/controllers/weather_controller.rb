class WeatherController < ApplicationController
  # GET /weather
  def index
    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end
end

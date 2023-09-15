class Api::LocationsController < ApplicationController
  before_action :set_location, only: [:show]

  def index
    @locations = Location.all
    render json: @locations
  end

  def show
    if @location
      render json: @location
    else
      render json: { error: 'Location not found' }, status: :not_found
    end
  end

  private
  def set_location
    @location = Location.find_by(location_id: params[:id])
  end
end

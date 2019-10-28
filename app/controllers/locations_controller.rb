# frozen_string_literal: true

class LocationsController < ApplicationController

  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def show
   
  end

  def new
    @location = authorize Location.new
  end
  
  def create
    @location = authorize Location.new(location_params)
    @location.save
    redirect_to location_path(@location)
  end

  def edit 

  end

  def update
    authorize @location

    @location.update(location_params) 
    redirect_to location_path(@location)
  end

  def destroy
    authorize @location

    Location.find(params[:id]).destroy
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end

  def set_location
    @location = Location.find(params[:id])
  end

end

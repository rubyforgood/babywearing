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
    @location = Location.new(location_params)
    authorize @location

    if @location.save
      redirect_to location_path(@location), notice: 'Location was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    authorize @location

    if @location.update(location_params)
      redirect_to location_path(@location), notice: 'Location was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    authorize @location

    redirect_to locations_path, alert: 'Location was successfully destroyed.' if @location.destroy
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end

  def set_location
    @location = Location.find(params[:id])
  end
end

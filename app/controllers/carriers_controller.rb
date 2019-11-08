# frozen_string_literal: true

class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update]

  def index
    @carriers = Carrier
                .with_attached_photos
                .includes(:home_location)
                .all

    init_filters || return
    @carriers = @filterrific.find

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @carrier = Carrier.new
    @locations = Location.all
    @categories = Category.all
    authorize @carrier
  end

  def create
    @carrier = Carrier.new(carrier_params)
    authorize @carrier
    @carrier.save

    if @carrier.errors.any?
      flash[:errors] = @carrier.errors.full_messages
      redirect_to new_carrier_path(@carrier)
    else
      flash[:success] = 'Carrier successfully created'
      redirect_to @carrier
    end
  end

  def edit
    @locations = Location.all
    @categories = Category.all
    authorize @carrier
  end

  def update
    authorize @carrier
    @carrier.update(carrier_params)
    if @carrier.errors.any?
      flash[:errors] = @carrier.errors.full_messages
      redirect_to edit_carrier_path(@carrier)
    else
      flash[:success] = 'Carrier successfully updated'
      redirect_to @carrier
    end
  end

  def destroy
    @carrier = Carrier.find(params[:id])
    authorize @carrier
    @carrier.destroy

    flash[:success] = 'Carrier successfully destroyed'
    redirect_to carriers_path
  end

  private

  def init_filters
    @filterrific = initialize_filterrific(
      Carrier.includes(:current_location, :category).with_attached_photos,
      params[:filterrific],
      select_options: {
        with_category_id: Carrier::FilterImpl.options_for_category_filter,
        with_current_location_id: Carrier::FilterImpl.options_for_current_location_filter,
        with_status: Carrier::FilterImpl.options_for_status_filter
      }
    )
  end

  def set_carrier
    @carrier = Carrier.find(params[:id])
  end

  def carrier_params
    params.require(:carrier).permit(
      :name,
      :item_id,
      :manufacturer,
      :model,
      :color,
      :size,
      :safety_link,
      :home_location_id,
      :current_location_id,
      :category_id,
      :default_loan_length_days,
      :status,
      photos: []
    )
  end
end

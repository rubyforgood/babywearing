# frozen_string_literal: true

class CarriersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_carrier, only: %i[show edit update]
  before_action :set_loan, only: [:show]

  def index
    @carriers = Carrier.with_attached_photos.includes(:home_location)
    init_filters || return
    @carriers = @filterrific.find.page(params[:page])
    extract_view_mode

    respond_to do |format|
      format.html
      format.js
    end
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

  def verify_view_mode
    view_modes = %w[icon list]
    @view_mode = view_modes.first unless @view_mode && view_modes.include?(@view_mode)
  end

  def extract_view_mode
    if params[:view].present?
      @view_mode = params[:view]
      cookies[:carrier_view] = @view_mode
    elsif cookies[:carrier_view].present?
      @view_mode = cookies[:carrier_view]
    end
    verify_view_mode
  end

  def init_filters
    @filterrific = initialize_filterrific(
      Carrier.includes(:current_location, :category).with_attached_photos, params[:filterrific],
      select_options: {
        with_category_id: Carrier::FilterImpl.options_for_category_filter,
        with_current_location_id: Carrier::FilterImpl.options_for_current_location_filter
      }
    )
  end

  def set_carrier
    @carrier = Carrier.find(params[:id])
  end

  def set_loan
    @current_loan = @carrier.loans.outstanding.first
  end

  def carrier_params
    params.require(:carrier).permit(
      :name, :item_id, :manufacturer,
      :model, :color, :size,
      :safety_link,
      :home_location_id,
      :current_location_id,
      :category_id,
      :default_loan_length_days,
      :state,
      :notes,
      photos: []
    )
  end
end

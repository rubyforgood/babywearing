# frozen_string_literal: true

class FeeTypesController < ApplicationController
  before_action :set_fee_type, only: %i[show edit update destroy]

  # GET /fee_types
  def index
    @fee_types = FeeType.all
  end

  # GET /fee_types/1
  def show
    authorize @fee_type
  end

  # GET /fee_types/new
  def new
    @fee_type = authorize FeeType.new
  end

  # GET /fee_types/1/edit
  def edit
  end

  # POST /fee_types
  def create
    @fee_type = authorize FeeType.new(fee_type_params)

    if @fee_type.save
      redirect_to @fee_type, notice: 'Fee type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /fee_types/1
  def update
    authorize @fee_type

    if @fee_type.update(fee_type_params)
      redirect_to @fee_type, notice: 'Fee type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /fee_types/1
  def destroy
    authorize @fee_type

    if @fee_type.destroy
      redirect_to fee_types_url, alert: 'Fee type was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_fee_type
    @fee_type = FeeType.find(params[:id])
  end

  def fee_type_params
    params.require(:fee_type).permit(:name, :fee_cents)
  end
end

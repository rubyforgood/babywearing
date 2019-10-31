# frozen_string_literal: true

class FeeTypesController < ApplicationController
  before_action :set_fee_type, only: [:show, :edit, :update, :destroy]

  # GET /fee_types
  # GET /fee_types.json
  def index
    @fee_types = FeeType.all
  end

  # GET /fee_types/1
  # GET /fee_types/1.json
  def show
    # binding.pry
  end

  # GET /fee_types/new
  def new
    @fee_type = authorize FeeType.new
  end

  # GET /fee_types/1/edit
  def edit
  end

  # POST /fee_types
  # POST /fee_types.json
  def create
    @fee_type = authorize FeeType.new(fee_type_params)

    respond_to do |format|
      if @fee_type.save
        format.html { redirect_to @fee_type, notice: 'Fee type was successfully created.' }
        format.json { render :show, status: :created, location: @fee_type }
      else
        format.html { render :new }
        format.json { render json: @fee_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fee_types/1
  # PATCH/PUT /fee_types/1.json
  def update
    authorize @fee_type

    respond_to do |format|
      if @fee_type.update(fee_type_params)
        format.html { redirect_to @fee_type, notice: 'Fee type was successfully updated.' }
        format.json { render :show, status: :ok, location: @fee_type }
      else
        format.html { render :edit }
        format.json { render json: @fee_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fee_types/1
  # DELETE /fee_types/1.json
  def destroy
    authorize @fee_type
    
    if @fee_type.destroy
      respond_to do |format|
        format.html { redirect_to fee_types_url, alert: 'Fee type was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee_type
      @fee_type = FeeType.find(params[:id])
    end

    def fee_type_params
      params.require(:fee_type).permit(:name, :amount)
    end
   
end


# frozen_string_literal: true

class MembershipTypesController < ApplicationController
  before_action :set_membership_type, only: [:show, :edit, :update, :destroy]

  # GET /membership_types
  # GET /membership_types.json
  def index
    @membership_types = MembershipType.all
  end

  # GET /membership_types/1
  # GET /membership_types/1.json
  def show
  end

  # GET /membership_types/new
  def new
    @membership_type = authorize MembershipType.new
  end

  # GET /membership_types/1/edit
  def edit
  end

  # POST /membership_types
  # POST /membership_types.json
  def create
    @membership_type = authorize MembershipType.new(membership_type_params)

    respond_to do |format|
      if @membership_type.save
        format.html { redirect_to @membership_type, notice: 'Membership type was successfully created.' }
        format.json { render :show, status: :created, location: @membership_type }
      else
        format.html { render :new }
        format.json { render json: @membership_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /membership_types/1
  # PATCH/PUT /membership_types/1.json
  def update
    authorize @membership_type

    respond_to do |format|
      if @membership_type.update(membership_type_params)
        format.html { redirect_to @membership_type, notice: 'Membership type was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership_type }
      else
        format.html { render :edit }
        format.json { render json: @membership_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /membership_types/1
  # DELETE /membership_types/1.json
  def destroy
    authorize @membership_type

    if @membership_type.destroy
      respond_to do |format|
        format.html { redirect_to membership_types_url, alert: 'Membership type was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership_type
    @membership_type = MembershipType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_type_params
    params.require(:membership_type).permit(:name, :fee_cents, :duration_days, :number_of_items, :description)
  end
end

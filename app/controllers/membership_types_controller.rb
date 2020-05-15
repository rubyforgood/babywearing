# frozen_string_literal: true

class MembershipTypesController < ApplicationController
  before_action :set_membership_type, only: %i[show edit update destroy]

  # GET /membership_types
  def index
    @membership_types = MembershipType.all
  end

  # GET /membership_types/1
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
  def create
    @membership_type = authorize MembershipType.new(membership_type_params)

    if @membership_type.save
      redirect_to membership_types_path, notice: 'Membership type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /membership_types/1
  def update
    authorize @membership_type

    if @membership_type.update(membership_type_params)
      redirect_to membership_types_path, notice: 'Membership type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /membership_types/1
  def destroy
    authorize @membership_type

    redirect_to membership_types_url, alert: 'Membership type was successfully destroyed.' if @membership_type.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership_type
    @membership_type = MembershipType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_type_params
    params.require(:membership_type).permit(:name, :short_name, :fee_cents, :duration_days, :number_of_items,
                                            :description)
  end
end

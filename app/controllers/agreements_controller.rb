# frozen_string_literal: true

class AgreementsController < ApplicationController
  before_action :set_agreement, only: [:show, :edit, :update, :destroy]


  def index
    @agreements = Agreement.all
  end

  def show
    @signed_agreement = SignedAgreement.find_by(agreement_id: @agreement.id, user_id: current_user.id)
  end

  def new
    @agreement = authorize Agreement.new
  end

  def create
    @agreement = authorize Agreement.new(agreement_params)

    respond_to do |format|
      if @agreement.save
        format.html { redirect_to @agreement, notice: 'Agreement was successfully created.' }
        format.json { render :show, status: :created, location: @agreement }
      else
        format.html { render :new }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit 

  end

  def update
    authorize @agreement

    respond_to do |format|
      if @agreement.update(agreement_params)
        format.html { redirect_to @agreement, notice: 'Agreement was successfully updated.' }
        format.json { render :show, status: :ok, location: @agreement }
      else
        format.html { render :edit }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @agreement
    
    if @agreement.destroy
      respond_to do |format|
        format.html { redirect_to agreements_url, alert: 'Agreement was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private 

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def agreement_params
    params.require(:agreement).permit(:title, :content)
  end
end

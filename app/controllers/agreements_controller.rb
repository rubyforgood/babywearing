# frozen_string_literal: true

class AgreementsController < ApplicationController
  before_action :set_agreement, only: %i[show edit update destroy]

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

    if @agreement.save
      redirect_to @agreement, notice: 'Agreement was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize @agreement

    if @agreement.update(agreement_params)
      redirect_to @agreement, notice: 'Agreement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @agreement

    redirect_to agreements_url, alert: 'Agreement was successfully destroyed.' if @agreement.destroy
  end

  private

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def agreement_params
    params.require(:agreement).permit(:title, :content)
  end
end

# frozen_string_literal: true

class SignedAgreementsController < ApplicationController
  before_action :set_agreement, only: [:new, :show]

  def show
    @signed_agreement = SignedAgreement.new
  end

  def create
    @signed_agreement = SignedAgreement.new(signed_agreement_params)

    respond_to do |format|
      if @signed_agreement.save
        format.html { redirect_to agreements_path, notice: 'Agreement was successfully signed.' }
      else
        format.html do
          redirect_to signed_agreement_path(@signed_agreement.agreement_id),
                      notice: @signed_agreement.errors.full_messages
        end
      end
    end
  end

  private

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def signed_agreement_params
    params.require(:signed_agreement).permit(
      :signature,
      :user_id,
      :agreement_id
    )
  end
end

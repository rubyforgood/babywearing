# frozen_string_literal: true

module AgreementScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_agreement
  end

  def set_agreement
    @agreement = Agreement.find(params[:agreement_id])
  end
end

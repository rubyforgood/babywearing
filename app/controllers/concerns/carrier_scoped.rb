# frozen_string_literal: true

module CarrierScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_carrier
  end

  def set_carrier
    @carrier = Carrier.find(params[:carrier_id])
  end
end

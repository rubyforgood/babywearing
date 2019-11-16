# frozen_string_literal: true

module CarriersHelper
  def carrier_badge_class(carrier)
    if carrier.available?
      "badge badge-success"
    else
      "badge badge-danger"
    end
  end
end

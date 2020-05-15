# frozen_string_literal: true

module CarriersHelper
  def carrier_badge_class(carrier)
    if carrier.available?
      'badge badge-success'
    else
      'badge badge-danger'
    end
  end

  def carrier_editable_states_for_select
    Carrier.aasm.states_for_select.reject { |s| s.first == 'Checked out' }
  end
end

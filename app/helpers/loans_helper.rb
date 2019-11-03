# frozen_string_literal: true

module LoansHelper
  def loans_default_selected_date_for(carrier)
    return Date.current unless carrier.default_loan_length_days

    Date.current + carrier.default_loan_length_days
  end
end

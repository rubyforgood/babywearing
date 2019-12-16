# frozen_string_literal: true

class LoanListingController < ApplicationController
  def index
    init_filters || return
    @loans = @filterrific.find
    authorize @loans

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def init_filters
    @filterrific = initialize_filterrific(
      Loan.includes([:carrier, :checkin_volunteer, :checkout_volunteer, :member]), params[:filterrific],
      select_options: {
        with_member_id: Loan::FilterImpl.options_for_member_filter,
        with_checkout_volunteer_id: Loan::FilterImpl.options_for_volunteer_filters,
        with_checkin_volunteer_id: Loan::FilterImpl.options_for_volunteer_filters,
        with_outstanding: Loan::FilterImpl.options_for_outstanding_filter
      }
    )
  end
end

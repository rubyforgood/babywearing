# frozen_string_literal: true

class LoanListingController < ApplicationController
  def index
    init_filters || return
    @loans = @filterrific.find.page(params[:page])
    authorize @loans

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def init_filters
    @filterrific = initialize_filterrific(
      current_tenant.loans.includes(%i[carrier checkin_volunteer checkout_volunteer borrower]), params[:filterrific],
      select_options: {
        with_borrower_id: Loan::FilterImpl.options_for_borrower_filter,
        with_checkout_volunteer_id: Loan::FilterImpl.options_for_volunteer_filters,
        with_checkin_volunteer_id: Loan::FilterImpl.options_for_volunteer_filters,
        with_outstanding: Loan::FilterImpl.options_for_yes_no_filter,
        with_overdue: Loan::FilterImpl.options_for_yes_no_filter
      }
    )
  end
end

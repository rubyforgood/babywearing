# frozen_string_literal: true

module Carriers
  class LoansController < ApplicationController
    include CarrierScoped

    respond_to :html, :json

    def new
      @loan = authorize @carrier.loans.new
      respond_modal_with @loan
    rescue Pundit::NotAuthorizedError
      render_not_found
    end

    def create
      @loan = @carrier.loans.new(loan_params)
      authorize @loan
      @loan.save

      respond_modal_with @loan, location: carrier_path(@carrier)
    end

    private

    def loan_params
      params.require(:loan).permit(:member_id, :due_date)
    end
  end
end

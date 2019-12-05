# frozen_string_literal: true

module Carriers
  class LoansController < ApplicationController
    include CarrierScoped

    respond_to :html, :json

    def new
      @loan = authorize @carrier.loans.new
      respond_modal_with @loan
    end

    def create
      @loan = @carrier.loans.new(loan_params)
      authorize @loan
      @loan.save

      respond_modal_with @loan, location: carrier_path(@carrier)

      send_success_email if @loan.persisted?
    end

    private

    def loan_params
      params.require(:loan).permit(:member_id, :due_date)
    end

    def send_success_email
      ReminderMailer.with(user_name: @loan.member.first_name,
                          user_email: @loan.member.email,
                          carrier_name: @carrier.display_name,
                          location: @carrier.current_location.name,
                          due_date: @loan.due_date.to_s).successful_checkout_email.deliver_later
    end
  end
end

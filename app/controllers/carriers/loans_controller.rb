# frozen_string_literal: true

module Carriers
  class LoansController < ApplicationController
    include CarrierScoped
    before_action :verify_state, except: %i[edit update]

    respond_to :html, :json

    def create
      @loan = @carrier.loans.new(loan_params)
      authorize @loan
      @loan.save
      respond_modal_with @loan, location: carrier_path(@carrier)

      send_success_email if @loan.persisted?
    end

    def edit
      @loan = authorize @carrier.loans.find(params[:id])
      @checkin = params[:checkin].present?
      respond_modal_with @loan
    end

    def new
      @loan = authorize @carrier.loans.new
      respond_modal_with @loan
    end

    def update
      @loan = authorize @carrier.loans.find(params[:id])
      update_loan

      respond_modal_with @loan, location: carrier_path(@carrier)
    end

    private

    def update_loan
      merging = {}
      merging = { checkin_volunteer_id: current_user.id } if @loan.outstanding? && loan_params[:returned_on].present?
      @loan.update(loan_params.merge(merging))
    end

    def loan_params
      params.require(:loan).permit(:borrower_id, :due_date, :returned_on)
    end

    def send_success_email
      ReminderMailer.with(user_name: @loan.borrower.first_name,
                          user_email: @loan.borrower.email,
                          carrier_name: @carrier.display_name,
                          location: @carrier.current_location.name,
                          due_date: @loan.due_date.to_s).successful_checkout_email.deliver_later
    end

    def verify_state
      render_not_found && return unless @carrier.may_checkout?
    end
  end
end

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
      if params[:checkin].present?
        @checkin = true
        @loan.returned_on = Time.zone.today
      end

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

    def loan_params
      params.require(:loan).permit(:borrower_id, :due_date, :returned_on)
    end

    def send_success_email
      CheckoutMailer.checkout_email(@loan).deliver_later
    end

    def update_loan
      merging = {}
      merging = { checkin_volunteer_id: current_user.id } if @loan.outstanding? && loan_params[:returned_on].present?
      @loan.update(loan_params.merge(merging))
    end

    def verify_state
      render_not_found && return unless @carrier.may_checkout?
    end
  end
end

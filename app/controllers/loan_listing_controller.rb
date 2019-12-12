# frozen_string_literal: true

class LoanListingController < ApplicationController
  def index
    @loans = Loan.all
    authorize @loans
  end
end

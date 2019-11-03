# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Loans", type: :request do
  let(:volunteer) { users(:volunteer) }
  let(:carrier)   { carriers(:carrier) }
  let(:valid_params) { { member_id: users(:member).id, due_date: Date.current + 5.days } }

  describe 'POST /loans' do
    it_behaves_like 'admin and volunteer authorized-only resource', :post do
      let(:endpoint) { carrier_loans_path(carrier) }
      let(:params) { { loan: valid_params } }
    end

    context 'with valid attributes' do
      it 'creates a loan for the carrier, with current user as a checkout volunteer' do
        sign_in volunteer

        post carrier_loans_path(carrier), params: { loan: valid_params }

        expect(Loan.count).to eq 1
        expect(Loan.first.checkout_volunteer).to eq volunteer
      end

      it 'without due_date specified defaults to carriers default_loan_length_days' do
        sign_in volunteer

        post carrier_loans_path(carrier), params: { loan: valid_params.except(:due_date) }

        expect(Loan.count).to eq 1
        expect(Loan.first.due_date).to eq Date.current + carrier.default_loan_length_days
      end
    end

    context 'with invalid attributes' do
      it "can't create a lone wihtout the member" do
        sign_in volunteer

        post carrier_loans_path(carrier), params: { loan: valid_params.except(:member_id) }

        expect(response.body).to match(/Member must exist/)
        expect(Loan.count).to eq 0
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Loans", type: :request do
  let(:volunteer) { users(:volunteer) }
  let(:member) { users(:member) }
  let(:carrier) { carriers(:carrier) }
  let(:valid_params) { { borrower_id: users(:member).id, due_date: Date.current + 5.days } }
  let(:checked_out_carrier) { carriers(:checked_out) }

  describe '#create' do
    it_behaves_like 'admin and volunteer authorized-only resource', :post do
      let(:endpoint) { carrier_loans_path(carrier) }
      let(:params) { { loan: valid_params } }
    end

    context 'with valid attributes' do
      it 'creates a loan for the carrier, with current user as a checkout volunteer' do
        sign_in volunteer

        expect { post carrier_loans_path(carrier), params: { loan: valid_params } }.to change(Loan, :count).by(1)
        expect(Loan.last.checkout_volunteer).to eq volunteer
      end

      it 'without due_date specified defaults to carriers default_loan_length_days' do
        sign_in volunteer

        expect { post carrier_loans_path(carrier), params: { loan: valid_params.except(:due_date) } }
          .to change(Loan, :count).by(1)

        expect(Loan.last.due_date).to eq Date.current + carrier.default_loan_length_days
      end
    end

    context 'with invalid attributes' do
      it "can't create a loan without the borrower" do
        sign_in volunteer

        expect { post carrier_loans_path(carrier), params: { loan: valid_params.except(:borrower_id) } }
          .not_to change(Loan, :count)
        expect(response.body).to match(/Borrower must be selected/)
      end
    end
  end

  describe '#edit' do
    let(:loan) { carriers(:available).loans.create(borrower: member, checkout_volunteer: volunteer) }

    it_behaves_like 'admin and volunteer authorized-only resource', :get do
      let(:endpoint) { edit_carrier_loan_path(loan.carrier, loan) }
      let(:params) { { loan: { due_date: 1.year.from_now } } }
    end
  end

  describe '#new' do
    it_behaves_like 'admin and volunteer authorized-only resource', :get do
      let(:endpoint) { new_carrier_loan_path(carrier) }
    end
    context 'when carrier not available' do
      it 'returns a 404' do
        sign_in volunteer
        get new_carrier_loan_path(checked_out_carrier)

        expect(response).to be_not_found
      end
    end
  end

  describe '#update' do
    context 'when checking in' do
      it 'updates the loan and the carrier state and the checkin volunteer' do
        sign_in volunteer
        loan = loans(:outstanding)
        carrier = carriers(:checked_out)
        returned = Time.zone.today
        put carrier_loan_path(carrier, loan), params: { loan: { returned_on: Time.zone.today } }

        expect(response).to redirect_to(carrier_path(carrier))
        loan.reload
        expect(loan.returned_on).to eq(returned)
        expect(loan.checkin_volunteer_id).to eq(volunteer.id)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "LoanListing", type: :request do
  describe '#index' do
    let(:admin) { users(:admin) }

    describe 'permissions' do
      it_behaves_like 'admin authorized-only resource', :get do
        let(:endpoint) { loan_listing_path }
      end
    end

    context 'with logged in admin' do
      before do
        sign_in admin
      end

      it 'shows empty table' do
        Loan.destroy_all
        get loan_listing_path

        expect(response).to be_successful
        expect(response.body).to match(/No loans to show/)
      end

      it 'shows the items' do
        get loan_listing_path

        expect(response).to be_successful
      end
    end
  end
end

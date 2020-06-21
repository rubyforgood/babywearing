# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FeeTypes', type: :request do
  let!(:fee_type) { fee_types(:upgrade) }
  let(:organization) { organizations(:midatlantic) }

  describe 'GET /fee_types' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { fee_types_url }
    end
    it 'gets the index' do
      sign_in users(:admin)
      get fee_types_url

      expect(response).to be_successful
      expect(response.body).to match(/Upgrade Membership/)
    end
  end

  describe 'GET /fee_types/new' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_fee_type_url }
    end
  end

  describe 'POST /fee_types' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { fee_types_url }
      let(:params) { { fee_type: { name: 'Test', fee_cents: 100 } } }
    end

    let(:valid_attr) { { name: 'Test', fee_cents: 10 } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates a fee_type' do
        sign_in users(:admin)
        post fee_types_url, params: { fee_type: valid_attr }

        expect(response).to redirect_to(fee_type_path(assigns(:fee_type)))
        expect(flash[:notice]).to eq('Fee type was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doen't create a fee_type" do
        sign_in users(:admin)
        post fee_types_url, params: { fee_type: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /fee_types/:id' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { fee_type_url(fee_type) }
    end
    it 'gets the fee type' do
      sign_in users(:admin)
      get fee_type_url(fee_type)

      expect(response).to be_successful
      expect(response.body).to match(/Upgrade Membership/)
    end
  end

  describe 'PUT /fee_types/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:fee_type) { fee_types(:upgrade) }
      let(:endpoint) { fee_type_url(fee_type) }
      let(:params) { { fee_type: { name: 'Test', fee_cents: 10 } } }
    end

    let(:valid_attr) { { name: 'Test', fee_cents: 10 } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the fee_type' do
        sign_in users(:admin)
        put fee_type_url(fee_type), params: { fee_type: valid_attr }

        expect(fee_type.reload.fee_cents).to eq(10)
        expect(flash[:notice]).to eq('Fee type was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the fee_type" do
        sign_in users(:admin)
        put fee_type_url(fee_type), params: { fee_type: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'DELETE /fee_type/:id' do
    let(:fee_type) { FeeType.create(name: 'Test', fee_cents: 10, organization: organization) }

    it_behaves_like 'admin authorized-only resource', :delete do
      let(:fee_type) { FeeType.create(name: 'Test', fee_cents: 10, organization: organization) }
      let(:endpoint) { fee_type_url(fee_type) }
    end

    it 'destroys the fee_type' do
      sign_in users(:admin)
      delete fee_type_url(fee_type)

      expect(fee_type).not_to exist_in_database
      expect(response).to redirect_to(fee_types_url)
      expect(flash[:alert]).to eq('Fee type was successfully destroyed.')
    end
  end
end

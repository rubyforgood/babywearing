# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "FeeTypes", type: :request do
  let!(:fee_type) { fee_types(:upgrade) }

  describe 'GET /fee_type' do
    it 'has http status 200' do
      sign_in users(:member)
      send :get, fee_types_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Upgrade Membership/)
    end
  end

  describe "GET /fee_types/new" do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_fee_type_path }
    end
  end

  describe 'POST /fee_types' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { fee_types_path }
      let(:params) { { fee_type: { name: 'Test', amount: 100 } } }
    end

    let(:valid_attr) { { name: 'Test', amount: 10 } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates a fee_type' do
        sign_in users(:admin)
        send :post, fee_types_path, params: { fee_type: valid_attr }

        expect(response).to redirect_to(fee_type_path(assigns(:fee_type)))
        expect(flash[:notice]).to eq('Fee type was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doen't create a fee_type" do
        sign_in users(:admin)
        send :post, fee_types_path, params: { fee_type: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /fee_types/:id' do
    it 'has have_http_status 200' do
      sign_in users(:member)
      send :get, fee_types_path(fee_type)

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Upgrade Membership/)
    end
  end

  describe 'PUT /fee_types/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:fee_type) { fee_types(:upgrade) }
      let(:endpoint) { fee_type_path(fee_type) }
      let(:params) { { fee_type: { name: 'Test', amount: 10 } } }
    end

    let(:valid_attr) { { name: 'Test', amount: 10 } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the fee_type' do
        sign_in users(:admin)
        send :put, fee_type_path(fee_type), params: { fee_type: valid_attr }

        expect(flash[:notice]).to eq('Fee type was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the fee_type" do
        sign_in users(:admin)
        send :put, fee_type_path(fee_type), params: { fee_type: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'DELETE /fee_type/:id' do
    let(:fee_type) { FeeType.create(name: 'Test', amount: 10) }

    it_behaves_like "admin authorized-only resource", :delete do
      let(:fee_type) { FeeType.create(name: 'Test', amount: 10) }
      let(:endpoint) { fee_type_path(fee_type) }
    end

    it 'destroys the fee_type' do
      sign_in users(:admin)
      send :delete, fee_type_path(fee_type)

      expect(response).to have_http_status(:found)
      expect(flash[:alert]).to eq('Fee type was successfully destroyed.')
    end
  end
end

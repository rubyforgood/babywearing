# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "MembershipTypes", type: :request do
  let!(:membership_type) { membership_types(:annual) }

  describe 'GET /membership_types' do
    it 'has http status 200' do
      sign_in users(:member)
      send :get, membership_types_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Annual/)
    end
  end

  describe "GET /membership_types/new" do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_membership_type_path }
    end
  end

  describe 'POST /membership_types' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { membership_types_path }
      let(:params) do
        { membership_type: {
          name: 'Annual',
          fee_cents: 30_00,
          duration_days: 3,
          number_of_items: 3,
          description: "A text description goes here."
        } }
      end
    end

    let(:valid_attr) do
      {
        name: 'Annual',
        fee_cents: 30_00,
        duration_days: 3,
        number_of_items: 3,
        description: "A text description goes here."
      }
    end
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates a membership_type' do
        sign_in users(:admin)
        send :post, membership_types_path, params: { membership_type: valid_attr }

        expect(response).to redirect_to(membership_type_path(assigns(:membership_type)))
        expect(flash[:notice]).to eq('Membership type was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doen't create a membership_type" do
        sign_in users(:admin)
        send :post, membership_types_path, params: { membership_type: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /membership_type/:id' do
    it 'has have_http_status 200' do
      sign_in users(:member)
      send :get, membership_types_path(membership_type)

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Annual/)
    end
  end

  describe 'PUT /membership_type/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:membership_type) { membership_types(:annual) }
      let(:endpoint) { membership_type_path(membership_type) }
      let(:params) do
        { membership_type: {
          name: 'Annual',
          fee_cents: 30_00,
          duration_days: 3,
          number_of_items: 3,
          description: "A text description goes here."
        } }
      end
    end

    let(:valid_attr) do
      {
        name: 'Annual',
        fee_cents: 30_00,
        duration_days: 3,
        number_of_items: 3,
        description: "A text description goes here."
      }
    end
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the membership_type' do
        sign_in users(:admin)
        send :put, membership_type_path(membership_type), params: { membership_type: valid_attr }

        expect(flash[:notice]).to eq('Membership type was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the membership_type" do
        sign_in users(:admin)
        send :put, membership_type_path(membership_type), params: { membership_type: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'DELETE /membership_type/:id' do
    let(:membership_type) do
      MembershipType.create(
        name: 'Annual',
        fee_cents: 30_00,
        duration_days: 3,
        number_of_items: 3,
        description: "A text description goes here."
      )
    end

    it_behaves_like "admin authorized-only resource", :delete do
      let(:membership_type) do
        MembershipType.create(
          name: 'Annual',
          fee_cents: 30_00,
          duration_days: 3,
          number_of_items: 3,
          description: "A text description goes here."
        )
      end
      let(:endpoint) { membership_type_path(membership_type) }
    end

    it 'destroys the fee_type' do
      sign_in users(:admin)
      send :delete, membership_type_path(membership_type)

      expect(response).to have_http_status(:found)
      expect(flash[:alert]).to eq('Membership type was successfully destroyed.')
    end
  end
end

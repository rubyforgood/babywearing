# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Locations", type: :request do
  let!(:location) { locations(:lancaster) }

  describe 'GET /locations' do
    it 'has http status 200' do
      sign_in users(:member)
      send :get, locations_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Lancaster/)
    end
  end

  describe "GET /locations/new" do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_location_path }
    end
  end

  describe 'POST /locations' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { locations_path }
      let(:params) { { location: { name: 'Test' } } }
    end

    let(:valid_attr) { { name: 'Some location' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates a location' do
        sign_in users(:admin)
        send :post, locations_path, params: { location: valid_attr }

        expect(response).to redirect_to(location_path(assigns(:location)))
        expect(flash[:notice]).to eq('Location was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doen't create a location" do
        sign_in users(:admin)
        send :post, locations_path, params: { location: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /location/:id' do
    it 'has have_http_status 200' do
      sign_in users(:member)
      send :get, locations_path(location)

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Lancaster/)
    end
  end

  describe 'PUT /location/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:location) { locations(:lancaster) }
      let(:endpoint) { location_path(location) }
      let(:params) { { location: { name: 'Test' } } }
    end

    let(:valid_attr) { { name: 'New location' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the location' do
        sign_in users(:admin)
        send :put, location_path(location), params: { location: valid_attr }

        expect(flash[:notice]).to eq('Location was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the location" do
        sign_in users(:admin)
        send :put, location_path(location), params: { location: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'DELETE /location/:id' do
    let(:location) { Location.create(name: 'Test') }

    it_behaves_like "admin authorized-only resource", :delete do
      let(:location) { Location.create(name: 'Test') }
      let(:endpoint) { location_path(location) }
    end

    it 'destroys the location' do
      sign_in users(:admin)
      send :delete, location_path(location)

      expect(response).to have_http_status(:found)
      expect(flash[:alert]).to eq('Location was successfully destroyed.')
    end
  end
end

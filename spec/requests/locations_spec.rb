# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  let!(:location) { locations(:lancaster) }
  let(:organization) { organizations(:midatlantic) }

  describe 'GET /locations' do
    it 'has http status 200' do
      sign_in users(:member)
      send :get, locations_url

      expect(response).to be_successful
      expect(response.body).to match(/Lancaster/)
    end
  end

  describe 'GET /locations/new' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_location_url }
    end
  end

  describe 'POST /locations' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { locations_url }
      let(:params) { { location: { name: 'Test' } } }
    end

    let(:valid_attr) { { name: 'Some location' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates a location' do
        sign_in users(:admin)
        send :post, locations_url, params: { location: valid_attr }

        expect(response).to redirect_to(location_url(assigns(:location)))
        expect(flash[:notice]).to eq('Location was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a location' do
        sign_in users(:admin)
        send :post, locations_url, params: { location: invalid_attr }

        expect(response).to be_unprocessable
        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /location/:id' do
    context 'with a valid location' do
      it 'returns the location' do
        sign_in users(:member)
        send :get, location_url(location)

        expect(response).to be_successful
        expect(response.body).to match(/Lancaster/)
      end
    end

    context 'with an invalid location' do
      it 'returns a 404' do
        sign_in users(:member)
        send :get, location_url(123_456_789)

        expect(response).to be_not_found
      end
    end
  end

  describe 'PUT /location/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:location) { locations(:lancaster) }
      let(:endpoint) { location_url(location) }
      let(:params) { { location: { name: 'Test' } } }
    end

    let(:valid_attr) { { name: 'New location' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the location' do
        sign_in users(:admin)
        send :put, location_url(location), params: { location: valid_attr }

        expect(response).to redirect_to(location_url(location))
        expect(flash[:notice]).to eq('Location was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the location" do
        sign_in users(:admin)
        send :put, location_url(location), params: { location: invalid_attr }

        expect(response).to be_unprocessable
        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'DELETE /location/:id' do
    let(:location) { organization.locations.create(name: 'Test') }

    it_behaves_like 'admin authorized-only resource', :delete do
      let(:location) { organization.locations.create(name: 'Test') }
      let(:endpoint) { location_url(location) }
    end

    it 'destroys the location' do
      sign_in users(:admin)
      send :delete, location_url(location)

      expect(response).to redirect_to(locations_url)
      expect(flash[:alert]).to eq('Location was successfully destroyed.')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Agreements', type: :request do
  let!(:agreement) { agreements(:agreement) }
  let(:organization) { organizations(:midatlantic) }

  describe 'GET /agreements' do
    it 'has http status 200' do
      sign_in users(:member)
      send :get, agreements_url

      expect(response).to be_successful
      expect(response.body).to match(/Test Agreement/)
    end
  end

  describe 'GET /agreements/new' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_agreement_url }
    end
  end

  describe 'POST /agreements' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { agreements_url }
      let(:params) { { agreement: { name: 'Name' } } }
    end

    let(:valid_attr) { { name: 'Some agreement' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates a agreement' do
        sign_in users(:admin)
        send :post, agreements_url, params: { agreement: valid_attr }

        expect(response).to redirect_to(agreement_url(assigns(:agreement)))
        expect(flash[:notice]).to eq('Agreement was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doen't create a agreement" do
        sign_in users(:admin)
        send :post, agreements_url, params: { agreement: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /agreements/:id' do
    it 'has have_http_status 200' do
      sign_in users(:member)
      send :get, agreements_url(agreement)

      expect(response).to be_successful
      expect(response.body).to match(/Test Agreemen/)
    end
  end

  describe 'PUT /agreement/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:agreement) { agreements(:agreement) }
      let(:endpoint) { agreement_url(agreement) }
      let(:params) { { agreement: { name: 'Test' } } }
    end

    let(:valid_attr) { { name: 'New agreement' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the agreement' do
        sign_in users(:admin)
        send :put, agreement_url(agreement), params: { agreement: valid_attr }

        expect(flash[:notice]).to eq('Agreement was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the agreement" do
        sign_in users(:admin)
        send :put, agreement_url(agreement), params: { agreement: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'DELETE /location/:id' do
    let(:agreement) { Agreement.create(name: 'Test', organization: organization) }

    it_behaves_like 'admin authorized-only resource', :delete do
      let(:agreement) { Agreement.create(name: 'Test', organization: organization) }
      let(:endpoint) { agreement_url(agreement) }
    end

    it 'destroys the agreement' do
      sign_in users(:admin)
      send :delete, agreement_url(agreement)

      expect(response).to have_http_status(:found)
      expect(flash[:alert]).to eq('Agreement was successfully destroyed.')
    end
  end
end

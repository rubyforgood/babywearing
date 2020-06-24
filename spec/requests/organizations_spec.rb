# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organizations', type: :request do
  let!(:organization) { organizations(:midatlantic) }

  describe '#create' do
    let(:valid_attr) { { name: 'Test', subdomain: 'test', email: 'test@example.com' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates an organization' do
        sign_in users(:admin_org)

        expect do
          post organizations_url(subdomain: 'admin'), params: { organization: valid_attr }
        end.to change(Organization, :count)
        expect(response).to redirect_to(organization_url(assigns(:organization), subdomain: 'admin'))
        expect(flash[:notice]).to eq('Organization was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't create an organization" do
        sign_in users(:admin_org)

        expect do
          post organizations_url(subdomain: 'admin'), params: { organization: invalid_attr }
        end.not_to change(Organization, :count)
        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the organization' do
      sign_in users(:admin_org)
      delete organization_url(organizations(:emca), subdomain: 'admin')

      expect(response).to redirect_to(organizations_url(subdomain: 'admin'))
      expect(flash[:alert]).to eq('Organization was successfully destroyed.')
    end
  end

  describe '#edit' do
    it 'gets the edit form' do
      sign_in users(:admin_org)
      get edit_organization_url(organization, subdomain: 'admin')

      expect(response).to be_successful
      expect(response.body).to match(/Edit Organization/)
    end
  end

  describe '#index' do
    it 'gets the index' do
      sign_in users(:admin_org)
      get organizations_url(subdomain: 'admin')

      expect(response).to be_successful
      expect(response.body).to match(/#{organization.subdomain}/)
    end
  end

  describe '#new' do
    it 'gets new' do
      sign_in users(:admin_org)
      get new_organization_url(subdomain: 'admin')

      expect(response).to be_successful
      expect(response.body).to match(/New Organization/)
    end
  end

  describe '#show' do
    it 'shows the organization' do
      sign_in users(:admin_org)
      get organization_url(organization, subdomain: 'admin')

      expect(response).to be_successful
      expect(response.body).to match(/#{organization.name}/)
    end
  end

  describe '#update' do
    let(:valid_attr) { { name: 'New name', subdomain: 'new' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the organization' do
        sign_in users(:admin_org)
        put organization_url(organization, subdomain: 'admin'), params: { organization: valid_attr }

        expect(flash[:notice]).to eq('Organization was successfully updated.')
        expect(organization.reload.name).to eq('New name')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the organization" do
        sign_in users(:admin_org)
        original = organization.name
        put organization_url(organization, subdomain: 'admin'), params: { organization: invalid_attr }

        expect(response.body).to match(/prohibited this/)
        expect(organization.reload.name).to eq(original)
      end
    end
  end
end

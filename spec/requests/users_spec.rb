# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:admin)  { users(:admin) }
  let(:member) { users(:member) }
  let(:volunteer) { users(:volunteer) }

  describe '#edit' do
    it_behaves_like 'admin and volunteer authorized-only resource', :get do
      let(:endpoint) { edit_user_url(member) }
    end

    it 'produces the edit form' do
      sign_in admin
      get edit_user_url(member)

      expect(response).to be_successful
    end
  end

  describe '#index' do
    it_behaves_like 'admin and volunteer authorized-only resource', :get do
      let(:endpoint) { users_url }
    end

    it 'produces the index' do
      sign_in admin
      get users_url

      expect(response).to be_successful
    end
  end

  describe '#show' do
    it_behaves_like 'admin and volunteer authorized-only resource', :get do
      let(:endpoint) { user_url(member) }
    end

    it 'produces the user show' do
      sign_in admin
      get user_url(member)

      expect(response).to be_successful
    end

    it 'includes user loans' do
      sign_in admin
      get user_url(users(:borrower))

      expect(response).to be_successful
      expect(response.body).to match(/checked out carrier/)
    end

    it 'includes user memberships' do
      sign_in admin
      get user_url(member)

      expect(response).to be_successful
      expect(response.body).to match(/#{member.memberships.first.expiration}/)
    end
  end

  describe '#update' do
    it_behaves_like 'admin and volunteer authorized-only resource', :put do
      let(:endpoint) { user_url(member) }
      let(:params) { { user: { first_name: 'Test' } } }
    end

    let(:valid_attr) { { first_name: 'New' } }
    let(:invalid_attr) { { first_name: '' } }

    context 'with valid attributes' do
      it 'updates the user' do
        sign_in admin
        put user_url(member), params: { user: valid_attr }

        expect(flash[:notice]).to eq('User was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the user" do
        sign_in admin
        put user_url(member), params: { user: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end

    context 'with volunteer logged in' do
      it 'does not allow updating the role' do
        sign_in volunteer
        put user_url(member), params: { user: { role: 'volunteer' } }

        expect(member.reload.role).to eq('user')
      end
    end
  end
end

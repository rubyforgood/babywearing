# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application', type: :request do
  describe 'no tenant redirect' do
    context 'without session' do
      it 'redirects to home index' do
        get root_url(subdomain: nil)

        expect(response).to redirect_to(home_index_url(subdomain: nil))
      end
    end

    context 'with nonadmin org session' do
      it 'redirects to home index' do
        sign_in users(:member)
        get root_url(subdomain: nil)

        expect(response).to redirect_to(home_index_url(subdomain: nil))
      end
    end
  end

  describe 'wrong tenant redirect' do
    it 'redirects to sign in' do
      sign_in users(:member)
      get users_url(subdomain: 'admin')

      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'admin organization redirect' do
    context 'with no session' do
      it 'redirects to sign in' do
        get root_url(subdomain: 'admin')

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end

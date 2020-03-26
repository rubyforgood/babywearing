# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users::Memberships", type: :request do
  let(:volunteer) { users(:volunteer) }
  let(:nonmember) { users(:nonmember) }
  let(:member) { users(:member) }
  let(:membership) { memberships(:member) }
  let(:membership_type) { membership_types(:annual) }
  let(:effective_date) { Time.zone.today }
  let(:valid_params) do
    { membership_type_id: membership_type.id,
      effective: effective_date,
      expiration: Time.zone.today + 1.year }
  end

  describe '#create' do
    it_behaves_like 'admin and volunteer authorized-only resource', :post do
      let(:endpoint) { user_memberships_url(nonmember) }
      let(:params) { { membership: valid_params } }
    end
    context 'with valid attributes' do
      it 'creates the membership' do
        sign_in volunteer
        expect { post user_memberships_url(nonmember), params: { membership: valid_params } }
          .to change(Membership, :count).by(1)
        expect(response).to redirect_to(user_url(nonmember))
        expect(Membership.all.map(&:user_id)).to include(nonmember.id)
      end
    end

    context 'with incomplete attributes' do
      it 'creates the membership' do
        sign_in volunteer

        expect { post user_memberships_url(nonmember), params: { membership: valid_params.merge(effective: "") } }
          .not_to change(Membership, :count)
        expect(response.body).to match(/form data-modal=\"true\"/)
        expect(response.body).to match(/Create Membership/)
        expect(response.body).to match(/Effective can&#39;t be blank/)
      end
    end
  end

  describe '#destroy' do
    it_behaves_like 'admin and volunteer authorized-only resource', :delete do
      let(:endpoint) { user_membership_url(member, membership) }
    end
    it 'destroys the membership' do
      sign_in volunteer

      expect { delete user_membership_url(member, membership) }.to change(Membership, :count).by(-1)
      expect(response).to redirect_to(user_url(member))
    end
  end

  describe '#edit' do
    it_behaves_like 'admin and volunteer authorized-only resource', :get do
      let(:endpoint) { edit_user_membership_url(member, membership) }
      let(:params) { { membership: valid_params.merge(id: membership.id) } }
    end
    it 'brings up the edit form modally' do
      sign_in volunteer
      get edit_user_membership_url(member, membership)

      expect(response).to be_successful
    end
  end

  describe '#new' do
    it_behaves_like 'admin and volunteer authorized-only resource', :get do
      let(:endpoint) { new_user_membership_url(nonmember) }
    end
    it 'loads the modal form' do
      sign_in volunteer
      get new_user_membership_url(nonmember)

      expect(response).to be_successful
      expect(response.body).to match(/form data-modal=\"true\"/)
      expect(response.body).to match(/Create Membership/)
    end
  end

  describe '#update' do
    it_behaves_like 'admin and volunteer authorized-only resource', :put do
      let(:endpoint) { user_membership_url(member, membership) }
      let(:params) { { membership: valid_params } }
    end
    context 'with invalid attributes' do
      it 'does not update the membership and returns to the modal form' do
        sign_in volunteer

        original_expiration = membership.expiration
        new_expiration = membership.effective - 1.day
        put user_membership_url(member, membership),
            params: { membership: valid_params.merge(expiration: new_expiration) }

        expect(response.body).to match(/Expiration cannot be before effective date/)
        expect(membership.reload.expiration).to eq(original_expiration)
      end
    end

    context 'with valid attributes' do
      it 'updates the membership' do
        sign_in volunteer

        new_expiration = Time.zone.today + 1.month
        put user_membership_url(member, membership),
            params: { membership: valid_params.merge(expiration: new_expiration) }

        expect(response).to redirect_to(user_url(member))
        expect(membership.reload.expiration).to eq(new_expiration)
      end
    end
  end
end

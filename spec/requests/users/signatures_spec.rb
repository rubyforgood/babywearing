# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Signatures', type: :request do
  let(:volunteer) { users(:volunteer) }
  let(:nonmember) { users(:nonmember) }
  let(:member) { users(:member) }
  let(:version) { agreement_versions(:agreement_version) }
  let(:valid_params) do
    { agreement_version_id: version.id,
      signature: 'ABC' }
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'creates the signature' do
        sign_in member

        expect { post user_signatures_url(member), params: { signature: valid_params } }
          .to change(member.signatures, :count)
        expect(response).to redirect_to(user_signatures_url(member))
        expect(member.signatures.last.signature).to eq('ABC')
      end
    end

    context 'with incomplete attributes' do
      it 'does not create the signature' do
        sign_in member

        expect { post user_signatures_url(member), params: { signature: valid_params.merge(signature: '') } }
          .not_to change(member.signatures, :count)
        expect(flash[:error].first).to match(/Signature can't be blank/)
      end
    end
  end

  describe '#index' do
    it 'lists the signed and unsigned agreements' do
      sign_in member
      get user_signatures_url(member)

      expect(response).to be_successful
    end
  end

  describe '#new' do
    it 'loads the signature form' do
      sign_in member
      get new_user_signature_url(member, agreement_version_id: version.id)

      expect(response).to be_successful
      expect(response.body).to match(/Sign #{version.title}/)
    end
  end
end

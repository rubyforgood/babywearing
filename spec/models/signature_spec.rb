# frozen_string_literal: true

RSpec.describe Signature do
  let(:user) { users(:user) }
  let(:agreement) { agreements(:agreement) }
  let(:agreement_version) { agreement_versions(:agreement_version) }
  let(:signature) { signatures(:signature) }
  let(:nonmember_signature) { signatures(:nonmember_signature) }
  let(:nonmember_agreement_signature) { signatures(:nonmember_agreement_signature) }
  let(:member_agreement_signature) { signatures(:member_agreement_signature) }

  describe '.active' do
    it 'returns the signatures for the active agreement versions' do
      expect(described_class.active).to match_array([signature,
                                                     member_agreement_signature,
                                                     nonmember_signature,
                                                     nonmember_agreement_signature])
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:agreement_version) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:signature) }
    it { is_expected.to validate_presence_of(:signed_at) }
  end
end

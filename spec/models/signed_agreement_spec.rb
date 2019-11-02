# frozen_string_literal: true

RSpec.describe SignedAgreement do
  let(:user) { users(:user) }
  let(:agreement) { agreements(:agreement) }

  it 'is valid with valid attributes' do
    expect(described_class.new(
             user_id: user.id,
             agreement_id: agreement.id,
             signature: 'RFG'
           )).to be_valid
  end

  it 'is not valid without a signature' do
    expect(described_class.new(signature: nil)).not_to be_valid
  end
end

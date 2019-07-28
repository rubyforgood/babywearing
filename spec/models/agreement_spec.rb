RSpec.describe Agreement do
  fixtures :users, :agreements
  
  let(:user) { users(:user) }
  let(:agreement) { agreements(:agreement) }

  describe '#signed_by?' do
    context 'when the agreement is not signed' do
      it 'returns false' do
        expect(agreement.signed_by?(user)).to eq false
      end
    end

    context 'when the agreement is signed' do
      it 'returns true' do
        SignedAgreement.create(user: user, agreement: agreement, signature: 'RFG')

        expect(agreement.signed_by?(user)).to eq true
      end
    end
  end
end
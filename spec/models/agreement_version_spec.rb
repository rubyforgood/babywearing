# frozen_string_literal: true

RSpec.describe AgreementVersion do
  let(:user) { users(:user) }
  let(:agreement) { agreements(:agreement) }
  let(:agreement_version) { agreement_versions(:agreement_version) }

  describe 'associations' do
    it { is_expected.to belong_to(:agreement) }
    it { is_expected.to belong_to(:last_modified_by).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:version) }

    describe 'single active version' do
      it 'does not allow more than one active version' do
        invalid = agreement.versions.create(
          title: 'a',
          content: 'b',
          last_modified_by: user,
          version: '2',
          active: true
        )

        expect(invalid).to be_invalid
        expect(invalid.errors[:active].first).to eq('cannot have more than one active version per agreement')
      end
    end
  end
end

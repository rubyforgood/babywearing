# frozen_string_literal: true

RSpec.describe AgreementVersion do
  let(:user) { users(:user) }
  let(:agreement) { agreements(:agreement) }
  let(:agreement_version) { agreement_versions(:agreement_version) }

  describe 'associations' do
    it { is_expected.to belong_to(:agreement) }
    it { is_expected.to belong_to(:last_modified_by).class_name('User') }
    it { is_expected.to validate_uniqueness_of(:version).scoped_to(:agreement_id).case_insensitive }
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

  describe '#copy_content' do
    context 'with no other version' do
      it 'gets no content from another version' do
        versionless = agreements(:versionless_agreement)
        version = versionless.versions.build
        version.copy_content

        expect(version.title).to be_nil
        expect(version.content).to be_nil
      end
    end

    context 'with an active version' do
      it 'gets the content from the active version' do
        version = agreement.versions.build
        version.copy_content

        expect(version.title).to eq(agreement_version.title)
        expect(version.content).to eq(agreement_version.content)
      end
    end

    context 'with an inactive version' do
      it 'gets the content from the most recent version' do
        inactive = agreements(:inactive_agreement)
        recent_version = agreement_versions(:inactive_version2)
        version = inactive.versions.build
        version.copy_content

        expect(version.title).to eq(recent_version.title)
        expect(version.content).to eq(recent_version.content)
      end
    end
  end
end

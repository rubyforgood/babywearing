# frozen_string_literal: true

RSpec.describe Agreement do
  let(:user) { users(:admin) }
  let(:organization) { organizations(:midatlantic) }
  let(:agreement) { agreements(:agreement) }

  describe 'associations' do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_many(:versions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    describe 'name uniqueness by organziation' do
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:organization_id).case_insensitive }
    end
  end

  describe '#active_version' do
    context 'with no versions at all' do
      it 'returns nil' do
        agreement = organization.agreements.create(name: 'My Versionless Agreement')

        expect(agreement.active_version).to be_nil
      end
    end

    context 'with no active version' do
      it 'returns nil' do
        agreement = organization.agreements.create(name: 'My Versionless Agreement')
        agreement.versions.create(version: '1')
        agreement.versions.create(version: '2')

        expect(agreement.active_version).to be_nil
      end
    end

    context 'with an active version' do
      it 'returns the active one' do
        agreement = organization.agreements.create(name: 'My Agreement')
        agreement.versions.create(title: 't', content: 'c', version: '1', last_modified_by: user)
        v2 = agreement.versions.create!(title: 't2', content: 'c2', version: '2', active: true, last_modified_by: user)

        expect(agreement.active_version).to eq(v2)
      end
    end
  end
end

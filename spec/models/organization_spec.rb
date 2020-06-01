# frozen_string_literal: true

RSpec.describe Organization, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:users) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:subdomain) }
    it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive }
  end

  describe '#admin' do
    context 'with admin organization' do
      it 'goes just by subdomain for now' do
        expect(organizations(:admin).admin?).to be true
      end

      it 'is indestructable' do
        admin_org = organizations(:admin)
        admin_org.destroy
        expect(admin_org).to exist_in_database
        expect(admin_org.errors[:base]).to include('Cannot delete admin organization.')
      end
    end

    context 'with non-admin organization' do
      it 'goes just by subdomain for now' do
        expect(organizations(:midatlantic).admin?).to be false
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe Organization, type: :model do
  let(:midatlantic) { organizations(:midatlantic) }

  describe 'associations' do
    it { is_expected.to have_many(:users) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:subdomain) }
    it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive }
    it { is_expected.to allow_value('8' * 10).for(:phone) }
    it { is_expected.not_to allow_value('8' * 3).for(:phone) }
    it { is_expected.not_to allow_value('8' * 11).for(:phone) }
    it { is_expected.not_to allow_value('').for(:phone) }
    it { is_expected.to allow_value(nil).for(:phone) }
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
        expect(midatlantic.admin?).to be false
      end
    end
  end

  describe 'phone' do
    context 'with dashes' do
      it 'scrubs the dashes' do
        midatlantic.phone = '456-345-5654'
        midatlantic.save

        expect(midatlantic.phone).to eq('4563455654')
      end
    end

    context 'with parens and dash' do
      it 'scrubs the parens and dash' do
        midatlantic.phone = '(456) 345-5654'
        midatlantic.save

        expect(midatlantic.phone).to eq('4563455654')
      end
    end
  end
end

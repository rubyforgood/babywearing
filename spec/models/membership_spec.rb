# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:membership) { memberships(:member) }
  let(:expired) { memberships(:expired) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:membership_type) }
  it { is_expected.to validate_presence_of(:effective) }

  it 'has a valid fixtures' do
    expect(membership).to be_valid
    expect(expired).to be_valid
  end

  describe 'associations' do
    it 'requires a user' do
      membership.user = nil

      expect(membership).not_to be_valid
    end

    it 'requires a membership type' do
      membership.membership_type = nil

      expect(membership).not_to be_valid
    end
  end

  describe 'validations' do
    it 'sets the expiration based on membership type if necessary' do
      membership.expiration = nil
      membership.save

      expect(membership.expiration).to eq(membership.effective + membership.membership_type.duration_days.days)
    end

    it 'requires expiration not be before effective' do
      membership.expiration = membership.effective - 1.day

      expect(membership).not_to be_valid
    end
  end

  describe '#expired?' do
    context 'when expiration passed' do
      it 'returns true' do
        expect(expired.expired?).to be true
      end
    end

    context 'when expiration not passed' do
      it 'returns false' do
        expect(membership.expired?).to be false
      end
    end
  end
end

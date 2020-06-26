# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:member) { users(:member) }
  let(:upcoming) { users(:upcoming) }
  let(:nonmember) { users(:nonmember) }
  let(:expired) { users(:expired) }
  let(:admin) { users(:admin) }

  describe 'associations' do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_many(:signatures) }
  end

  describe 'validations' do
    it { is_expected.to allow_value('8' * 10).for(:phone_number) }
    it { is_expected.not_to allow_value('8' * 3).for(:phone_number) }
    it { is_expected.not_to allow_value('8' * 11).for(:phone_number) }
    it { is_expected.not_to allow_value('').for(:phone_number) }
    it { is_expected.not_to allow_value(nil).for(:phone_number) }
  end

  describe '#active_signatures' do
    context 'with no active signatures' do
      it 'returns an empty collection' do
        expect(nonmember.active_signatures).to be_empty
      end
    end

    context 'with active signatures' do
      it 'returns the signatures' do
        expect(member.active_signatures).to eq([signatures(:signature), signatures(:member_agreement_signature)])
      end
    end
  end

  describe '#current_membership' do
    context 'with no membership' do
      it 'is nil' do
        expect(nonmember.current_membership).to be_nil
      end
    end

    context 'with an expired membership' do
      it 'is nil' do
        expect(expired.current_membership).to be_nil
      end
    end

    context 'with current membership' do
      it 'returns the membership' do
        expect(member.current_membership).to eq(memberships(:member))
      end
    end

    context 'with upcoming membership' do
      it 'is nil' do
        expect(upcoming.current_membership).to be_nil
      end
    end
  end

  describe '#name_with_membership type' do
    context 'with no membership' do
      it 'just returns the name' do
        nonmember = users(:nonmember)

        expect(nonmember.name_with_membership).to eq(nonmember.name.full)
      end
    end

    context 'with current membership' do
      it 'returns the full name with the membership type short name' do
        expect(member.name_with_membership).to eq('Member Bember - SN')
      end
    end

    context 'with expired membership' do
      it 'returns the full name with the membership type short name indicating expired' do
        expired = users(:expired)

        expect(expired.name_with_membership).to eq('Expired Bember - AN (Expired)')
      end
    end
  end

  describe 'phone_number' do
    context 'with dashes' do
      it 'scrubs the dashes' do
        member.phone_number = '456-345-5654'
        member.save

        expect(member.phone_number).to eq('4563455654')
      end
    end

    context 'with parens and dash' do
      it 'scrubs the parens and dash' do
        member.phone_number = '(456) 345-5654'
        member.save

        expect(member.phone_number).to eq('4563455654')
      end
    end
  end

  describe '#unsigned_agreements' do
    context 'with no unsigned agreements' do
      it 'returns an empty collection' do
        expect(member.unsigned_agreements).to be_empty
      end
    end

    context 'with unsigned agreements' do
      it 'returns the collection' do
        expect(nonmember.unsigned_agreements).to match_array([
                                                               signatures(:signature).agreement_version,
                                                               signatures(:member_agreement_signature).agreement_version
                                                             ])
      end
    end
  end

  describe '#loans_available_to_member?' do
    let(:membership_type) { membership_types(:annual) } # allows 3 loans
    let(:carrier_1) { carriers(:available) }
    let(:carrier_2) { carriers(:available) }

    context 'with more checkouts allowed' do
      it 'returns true' do
        Loan.create(carrier: carrier_1,
                    borrower: member,
                    checkout_volunteer: admin,
                    due_date: Time.zone.today + 10.days)
        expect(member.loans_available_to_member?).to be true
      end
    end

    context 'with no more checkouts allowed' do
      it 'returns false' do
        Loan.create(carrier: carrier_1,
                    borrower: member,
                    checkout_volunteer: admin,
                    due_date: Time.zone.today + 10.days)
        Loan.create(carrier: carrier_2,
                    borrower: member,
                    checkout_volunteer: admin,
                    due_date: Time.zone.today + 10.days)
        expect(member.loans_available_to_member?).to be false
      end
    end
  end
end

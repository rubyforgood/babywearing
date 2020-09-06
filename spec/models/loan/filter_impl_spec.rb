# frozen_string_literal: true

RSpec.describe Loan::FilterImpl do
  let(:organization) { organizations(:midatlantic) }

  around do |example|
    ActsAsTenant.with_tenant(organization) do
      example.run
    end
  end

  describe '.with_overdue' do
    describe '.with_Yes' do
      it 'returns all overdue loans' do
        overdues = organization.loans.with_overdue('Yes')

        expect(overdues).to match_array([loans(:one_week_overdue), loans(:two_weeks_overdue)])
      end
    end

    describe '.with_No' do
      it 'returns all not overdue loans' do
        not_overdues = organization.loans.with_overdue('No')

        expect(not_overdues).to match_array([loans(:outstanding), loans(:returned), loans(:due_today_1),
                                             loans(:due_today_2), loans(:due_one_week)])
      end
    end

    describe '.with_Any' do
      it 'returns all loans' do
        all_loans = organization.loans.with_overdue('Any')

        expect(all_loans).to match_array(organization.loans.all)
      end
    end
  end

  describe '.with_outstanding' do
    context 'with parameter available' do
      it 'returns all and only outstanding loans' do
        loans = organization.loans.with_outstanding('Yes')

        expect(loans).to match_array([loans(:outstanding), loans(:due_one_week), loans(:due_today_1),
                                      loans(:due_today_2), loans(:one_week_overdue), loans(:two_weeks_overdue)])
      end

      it 'returns all and returned loans' do
        returned = loans(:returned)
        loans = organization.loans.with_outstanding('No')

        expect(loans.size).to eq(1)
        expect(loans.first.id).to eq(returned.id)
      end
    end
  end
end

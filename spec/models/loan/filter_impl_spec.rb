# frozen_string_literal: true

RSpec.describe Loan::FilterImpl do
  describe ".with_overdue" do
    describe '.with_Yes' do
      it "returns all overdue loans" do
        overdues = Loan.with_overdue('Yes')

        expect(overdues).to match_array([loans(:overdue_1), loans(:overdue_2)])
      end
    end

    describe '.with_No' do
      it "returns all not overdue loans" do
        not_overdues = Loan.with_overdue('No')

        expect(not_overdues).to match_array([loans(:outstanding), loans(:returned)])
      end
    end

    describe '.with_Any' do
      it "returns all loans" do
        all_loans = Loan.with_overdue('Any')

        expect(all_loans).to match_array(Loan.all)
      end
    end
  end

  describe ".with_outstanding" do
    context "with parameter available" do
      it "returns all and only outstanding loans" do
        loans = Loan.with_outstanding('Yes')

        expect(loans).to match_array([loans(:outstanding), loans(:overdue_1), loans(:overdue_2)])
      end

      it "returns all and returned loans" do
        returned = loans(:returned)
        loans = Loan.with_outstanding('No')

        expect(loans.size).to eq(1)
        expect(loans.first.id).to eq(returned.id)
      end
    end
  end
end

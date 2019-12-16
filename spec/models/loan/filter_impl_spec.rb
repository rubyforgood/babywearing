# frozen_string_literal: true

RSpec.describe Loan::FilterImpl do
  describe ".with_outstanding" do
    context "with parameter available" do
      it "returns all and only outstanding loans" do
        outstanding = loans(:outstanding)
        loans = Loan.with_outstanding('Yes')

        expect(loans.size).to eq(1)
        expect(loans.first.id).to eq(outstanding.id)
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

# frozen_string_literal: true

RSpec.describe Carrier::FilterImpl do
  describe ".with_checked_out" do
    context "with parameter yes" do
      it "returns all and only checked out ones" do
        checked_out_carrier = Carrier.first
        Loan.create(carrier: checked_out_carrier,
                    member: users(:user),
                    checkout_volunteer: users(:volunteer),
                    due_date: Time.zone.today + 10.days)
        carriers = Carrier.with_checked_out('Yes')

        expect(carriers.size).to eq(1)
        expect(carriers.first).to eq(checked_out_carrier)
      end
    end

    context "with parameter no" do
      it "returns all and only checked out ones" do
        checked_out_carrier = Carrier.first
        loan = Loan.create(carrier: checked_out_carrier,
                           member: users(:user),
                           checkout_volunteer: users(:volunteer),
                           due_date: Time.zone.today + 10.days)
        carriers = Carrier.with_checked_out('No')

        expect(carriers.size).to eq(Carrier.count - 1)
        expect(carriers).not_to include(checked_out_carrier)
        loan.destroy
      end
    end
  end
end

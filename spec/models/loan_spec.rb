# frozen_string_literal: true

RSpec.describe Loan do
  let(:member)    { users(:user) }
  let(:volunteer) { users(:volunteer) }

  let(:cart)    { Cart.new(member: member, volunteer: volunteer) }
  let(:carrier) { carriers(:carrier) }

  describe '#valid?' do
    context "with a cart, a carrier, and a due date" do
      let(:due_date) { DateTime.now + 1.days }

      subject { described_class.new(cart: cart, carrier: carrier, due_date: due_date) }

      it "returns true" do
        expect(subject).to be_valid
      end
    end
  end
end

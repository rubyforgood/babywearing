RSpec.describe Loan do
  describe '#valid?' do
    context "with a cart, a carrier, and a due date" do
      fixtures(:carriers)
      fixtures(:users)

      let(:user)    { User.first }
      let(:cart)    { Cart.new(user: user) }
      let(:carrier) { Carrier.first }

      let(:due_date) { DateTime.now + 1.days }

      subject { described_class.new(cart: cart, carrier: carrier, due_date: due_date) }

      it "returns true" do
        expect(subject).to be_valid
      end
    end
  end
end

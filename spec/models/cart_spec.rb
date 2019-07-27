RSpec.describe Cart do
  fixtures(:users)

  let(:user) { User.first }

  describe '#valid?' do
    context "with a user" do
      subject { described_class.new(user: user) }

      it 'returns true' do
        expect(subject).to be_valid
      end
    end
  end

  describe '#line_items' do
    fixtures(:carriers)

    let(:carrier)  { Carrier.first }
    let(:due_date) { Date.today + 1.days }

    subject { Cart.create!(user: user) }

    context "with a single loan" do
      let(:loan) { subject.loans.create!(carrier: carrier, due_date: due_date) }

      it 'returns an array containing the loan' do
        expect(subject.line_items).to eq [loan]
      end
    end
  end
end

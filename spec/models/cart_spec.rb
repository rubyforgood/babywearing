# frozen_string_literal: true

RSpec.describe Cart do
  let(:member)    { users(:user) }
  let(:volunteer) { users(:volunteer) }

  describe '#valid?' do
    context "with a member and a volunteer" do
      subject { described_class.new(member: member, volunteer: volunteer) }

      it 'returns true' do
        expect(subject).to be_valid
      end
    end
  end

  describe '#line_items' do
    let(:carrier)  { carriers(:carrier) }
    let(:due_date) { Date.today + 1.days }

    subject { described_class.create!(member: member, volunteer: volunteer) }

    context "with a single loan" do
      let(:loan) { subject.loans.create!(carrier: carrier, due_date: due_date) }

      it 'returns an array containing the loan' do
        expect(subject.line_items).to eq [loan]
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe Loan do
  let(:member)    { users(:user) }
  let(:volunteer) { users(:volunteer) }

  let(:carrier) { carriers(:carrier) }

  describe '#valid?' do
    context "with a member, a checkout volunteer, a carrier, and a due date" do
      subject do
        described_class.new(
          carrier: carrier,
          due_date: due_date,
          member: member,
          checkout_volunteer: volunteer
        )
      end

      let(:due_date) { DateTime.now + 1.days }

      it "returns true" do
        expect(subject).to be_valid
      end
    end
  end

  describe 'create' do
    it "sets the due date to the date specified" do
      due_date = 20.days.from_now.utc.to_date
      loan = described_class.create(
        carrier: carrier,
        member: member,
        checkout_volunteer: volunteer,
        due_date: due_date
      )

      expect(loan.due_date).to eq(due_date)
    end
  end

  context "without due date" do
    it "sets the due date to be the default number of days away" do
      freeze_time do
        loan = described_class.create(
          carrier: carrier,
          member: member,
          checkout_volunteer: volunteer
        )

        expect(loan.due_date).to eq(carrier.default_loan_length_days.days.from_now.utc.to_date)
      end
    end
  end

  describe '#checkin' do
    it "sets the returned_at and the checkin_volunteer" do
      freeze_time do
        loan = described_class.create(
          carrier: carrier,
          member: member,
          checkout_volunteer: volunteer
        )

        loan.checkin(volunteer)
        loan.reload

        expect(loan.returned_at).to eq(Time.now)
        expect(loan.checkin_volunteer).to eq(volunteer)
      end
    end
  end
end

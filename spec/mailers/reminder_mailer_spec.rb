# frozen_string_literal: true

RSpec.describe ReminderMailer, type: :mailer do
  let(:user) { users(:member) }
  let(:carrier) { carriers(:carrier) }
  let(:location) { locations(:washington) }

  describe '#overdue_email' do
    it 'renders the email' do
      due_date = Time.zone.today - 1.week
      mail = described_class.with(mailer_parameters(user, carrier, location, due_date)).overdue_email
      included_text = %W[This is a reminder that your
                         #{carrier.display_name} was due back to
                         #{location.name} on #{due_date}].join(' ')

      expect(mail.subject).to eq('Baby Carrier Overdue For Return')
      expect(mail.to).to eq([user.email])
      expect(mail.body).to include(included_text)
    end
  end

  describe '#due_today_email' do
    it 'renders the email' do
      mail = described_class.with(mailer_parameters(user, carrier, location)).due_today_email
      included_text = %W[This is a reminder that the
                         #{carrier.display_name} is due back to #{location.name} today].join(' ')

      expect(mail.subject).to eq('Baby Carrier Due For Return')
      expect(mail.to).to eq([user.email])
      expect(mail.body).to include(included_text)
    end
  end

  describe 'week_advance_notice_email' do
    it 'renders the email' do
      due_date = Time.zone.today + 1.week
      mail = described_class.with(mailer_parameters(user, carrier, location, due_date)).week_advance_notice_email
      included_text = %W[This is a reminder that your #{carrier.display_name}
                         is due back to #{location.name} on #{due_date}].join(' ')

      expect(mail.subject).to eq('Baby Carrier Due For Return in One Week')
      expect(mail.to).to eq([user.email])
      expect(mail.body).to include(included_text)
    end
  end

  describe 'successful_checkout_email' do
    it 'rendered the email' do
      due_date = Time.zone.today + 2.weeks
      mail = described_class.with(mailer_parameters(user, carrier, location, due_date)).successful_checkout_email
      included_text = "You have successfully checked out the #{carrier.display_name}"

      expect(mail.subject).to eq("You've Successfully Checked Out #{carrier.display_name}")
      expect(mail.to).to eq([user.email])
      expect(mail.body).to include(included_text)
    end
  end
end

def mailer_parameters(user, carrier, location, due = nil)
  {
    user_name: user.first_name,
    user_email: user.email,
    carrier_name: carrier.display_name,
    location: location.name,
    due_date: due.to_s
  }
end

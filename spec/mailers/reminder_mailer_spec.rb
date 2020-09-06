# frozen_string_literal: true

RSpec.describe ReminderMailer, type: :mailer do
  let(:loan) { loans(:due_one_week) }
  let(:user) { loan.borrower }
  let(:template) { email_templates(:reminder_one_week) }

  describe '#reminder_email' do
    context 'with active template' do
      it 'renders the email with the template text' do
        mail = described_class.reminder_email(loan, template)
        body = "Hello #{user.first_name},<p>This is to remind you that your #{loan.carrier.name} is "\
                "due on #{loan.due_date}.</p> "\
                '<p>Thank you,</p> <p>Midatlantic Babywearing</p>'

        expect(mail.subject).to eq(template.subject)
        expect(mail.to).to eq([user.email])
        expect(mail.body).to include(body)
        expect(mail.from).to eq([user.organization.reply_email])
      end
    end

    context 'with template from other organization' do
      it 'does not render the email' do
        mail = described_class.reminder_email(loans(:acme_outstanding), template)

        expect(mail.message).to be_a_kind_of(ActionMailer::Base::NullMail)
      end
    end

    context 'with inactive template' do
      it 'does not render the email' do
        template.update(active: false)
        mail = described_class.reminder_email(loan, template)

        expect(mail.message).to be_a_kind_of(ActionMailer::Base::NullMail)
      end
    end
  end
end

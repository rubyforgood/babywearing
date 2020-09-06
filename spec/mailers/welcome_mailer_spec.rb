# frozen_string_literal: true

RSpec.describe WelcomeMailer, type: :mailer do
  let(:user) { users(:member) }

  describe '#welcome_email' do
    let(:template) { email_templates(:welcome) }

    context 'with active template' do
      it 'renders the email with the template text' do
        mail = described_class.welcome_email(user.id)
        included_text = "Hello #{user.first_name},<p>It is our pleasure to welcome you"

        expect(mail.subject).to eq(template.subject)
        expect(mail.to).to eq([user.email])
        expect(mail.body).to include(included_text)
        expect(mail.from).to eq([user.organization.reply_email])
      end
    end

    context 'with inactive template' do
      it 'does not render the email' do
        template.update(active: false)
        mail = described_class.welcome_email(user.id)

        expect(mail.message).to be_a_kind_of(ActionMailer::Base::NullMail)
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe CheckoutMailer, type: :mailer do
  let(:loan) { loans(:outstanding) }
  let(:user) { loan.borrower }
  let(:template) { email_templates(:checkout) }

  describe '#checkout_email' do
    context 'with active template' do
      it 'renders the email with the template text' do
        ActsAsTenant.with_tenant(organizations(:midatlantic)) do
          mail = described_class.checkout_email(loan)
          body = "Hello #{user.first_name},<p>Thank you for checking out #{loan.carrier.name}. "\
                  "The carrier is due on #{loan.due_date}</p>."

          expect(mail.subject).to eq(template.subject)
          expect(mail.to).to eq([user.email])
          expect(mail.body).to include(body)
          expect(mail.from).to eq([user.organization.reply_email])
        end
      end
    end

    context 'with active template only from other organization' do
      it 'does not render the email' do
        ActsAsTenant.with_tenant(organizations(:acme)) do
          acme_template = email_templates(:acme_checkout)
          acme_template.update(active: false) # midatlantic has a template, make sure we don't use that
          acme_loan = loans(:acme_outstanding)
          mail = described_class.checkout_email(acme_loan)

          expect(mail.message).to be_a_kind_of(ActionMailer::Base::NullMail)
        end
      end
    end

    context 'with inactive template' do
      it 'does not render the email' do
        ActsAsTenant.with_tenant(organizations(:midatlantic)) do
          template.update(active: false)
          mail = described_class.checkout_email(loan)

          expect(mail.message).to be_a_kind_of(ActionMailer::Base::NullMail)
        end
      end
    end
  end
end

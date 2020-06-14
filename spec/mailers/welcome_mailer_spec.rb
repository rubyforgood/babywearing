# frozen_string_literal: true

RSpec.describe WelcomeMailer, type: :mailer do
  let(:user) { users(:member) }

  describe '#welcome_email' do
    it 'renders the email with a link to the site' do
      mail = described_class.welcome_email(user.id)
      included_text = "Welcome to #{user.organization.name}!"
      link_text = 'midatlantic.babywearing.exchange'

      allow(Rails.application.config).to receive(:short_server_name).and_return('prod')
      expect(mail.subject).to eq('Babywearing Account Registration')
      expect(mail.to).to eq([user.email])
      expect(mail.body).to include(included_text)
      expect(mail.body).to include(link_text)
    end

    it 'renders the email with a link to the site including the server subdomain' do
      mail = described_class.welcome_email(user.id)
      included_text = "Welcome to #{user.organization.name}!"
      link_text = 'midatlantic.stage.babywearing.exchange'

      allow(Rails.application.config).to receive(:short_server_name).and_return('stage')
      expect(mail.subject).to eq('Babywearing Account Registration')
      expect(mail.to).to eq([user.email])
      expect(mail.body).to include(included_text)
      expect(mail.body).to include(link_text)
    end
  end
end

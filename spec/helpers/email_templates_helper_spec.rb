# frozen_string_literal: true

RSpec.describe EmailTemplatesHelper do
  describe '#types_for_select' do
    it 'returns the correct types' do
      expect(helper.types_for_select).to eq(
        [%w[Checkout CheckoutEmailTemplate],
         %w[Reminder ReminderEmailTemplate],
         %w[Welcome WelcomeEmailTemplate]]
      )
    end
  end

  describe '#when_days_display' do
    context 'with reminder template' do
      it 'returns the when days as a string' do
        expect(helper.when_days_display(email_templates(:reminder_one_week))).to eq('7')
      end
    end

    context 'with other than template' do
      it 'returns N/A' do
        expect(helper.when_days_display(email_templates(:checkout))).to eq('N/A')
      end
    end
  end

  describe '#when_sent_display' do
    context 'with reminder template' do
      it 'returns the correct when sent value as a titleized string' do
        expect(helper.when_sent_display(email_templates(:reminder_one_week))).to eq('Before Due Date')
      end
    end

    context 'with other than template' do
      it 'returns N/A' do
        expect(helper.when_sent_display(email_templates(:checkout))).to eq('N/A')
      end
    end
  end
end

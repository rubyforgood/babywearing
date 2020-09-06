# frozen_string_literal: true

RSpec.describe ReminderEmailTemplate do
  let(:template) { subject }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:when_sent) }

    context 'with when_sent before_due_date' do
      before { allow(template).to receive(:when_sent).and_return('before_due_date') }

      it { is_expected.to validate_presence_of(:when_days) }
    end

    context 'with when_sent after_due_date' do
      before { allow(template).to receive(:when_sent).and_return('after_due_date') }

      it { is_expected.to validate_presence_of(:when_days) }
    end

    context 'with when_sent on_due_date' do
      before { allow(template).to receive(:when_sent).and_return('on_due_date') }

      it { is_expected.not_to validate_presence_of(:when_days) }
    end
  end
end

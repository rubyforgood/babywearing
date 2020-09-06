# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReminderEmailJob, type: :job do
  let(:all_loans) { %i[due_today_1 due_today_2 due_one_week one_week_overdue two_weeks_overdue] }
  let(:loan1) { loans(:due_today_1) }
  let(:loan2) { loans(:due_today_2) }

  describe '#perform' do
    context 'with due today' do
      it 'sends emails to borrowers with correct args' do
        loan1 = loans(:due_today_1)
        all_loans.each do |l| # just do one so we can check args
          loans(l).destroy unless %i[due_today_1].include?(l)
        end
        expect do
          described_class.new.perform
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob).with('ReminderMailer', 'reminder_email', 'deliver_now',
                                                                     args: [loan1, email_templates(:reminder_today)])
      end

      it 'does not send email for carrier returned' do
        all_loans.each do |l|
          loans(l).destroy unless %i[due_today_1 due_today_2].include?(l)
        end
        returned = loans(:due_today_1)
        returned.update(returned_on: Time.zone.today)

        expect do
          described_class.new.perform
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob).once # just for due_today_2
      end

      it 'sends emails to all borrowers due today' do
        all_loans.each do |l| # just do one so we can check args
          loans(l).destroy unless %i[due_today_1 due_today_2].include?(l)
        end
        expect do
          described_class.new.perform
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob).twice
      end
    end

    context 'with due in one week' do
      it 'sends emails with correct params' do
        loan1 = loans(:due_one_week)
        all_loans.each do |l|
          loans(l).destroy unless %i[due_one_week].include?(l)
        end
        expect do
          described_class.new.perform
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob).with('ReminderMailer', 'reminder_email', 'deliver_now',
                                                                     args: [loan1, email_templates(:reminder_one_week)])
      end
    end

    context 'with one week overdue' do
      it 'sends emails with correct params' do
        loan1 = loans(:one_week_overdue)
        all_loans.each do |l|
          loans(l).destroy unless %i[one_week_overdue].include?(l)
        end
        expect do
          described_class.new.perform
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob).with(
          'ReminderMailer', 'reminder_email', 'deliver_now',
          args: [loan1, email_templates(:reminder_week_overdue)]
        )
      end
    end
  end
end

# frozen_string_literal: true

class ReminderEmailJob < ApplicationJob
  queue_as :mailers

  def perform(*_args)
    overdues
    due_todays
    due_in_futures
  end

  private

  def overdues
    Organization.all.each do |org|
      ActsAsTenant.with_tenant(org) do
        org.reminder_email_templates.active.after_due_date.each do |template|
          org.loans.outstanding.where(due_date: Time.zone.today - template.when_days.days).each do |loan|
            ReminderMailer.reminder_email(loan, template).deliver_later
          end
        end
      end
    end
  end

  def due_todays
    Organization.all.each do |org|
      ActsAsTenant.with_tenant(org) do
        org.reminder_email_templates.active.on_due_date.each do |template|
          org.loans.outstanding.where(due_date: Time.zone.today).each do |loan|
            ReminderMailer.reminder_email(loan, template).deliver_later
          end
        end
      end
    end
  end

  def due_in_futures
    Organization.all.each do |org|
      ActsAsTenant.with_tenant(org) do
        org.reminder_email_templates.active.before_due_date.each do |template|
          org.loans.outstanding.where(due_date: Time.zone.today + template.when_days.days).each do |loan|
            ReminderMailer.reminder_email(loan, template).deliver_later
          end
        end
      end
    end
  end
end

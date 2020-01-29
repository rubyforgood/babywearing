# frozen_string_literal: true

def mailer_parameters(loan)
  {
    user_name: loan.borrower.first_name,
    user_email: loan.borrower.email,
    carrier_name: carrier.display_name,
    location: loan.location.name,
    due_date: loan.due_date
  }
end

# frozen_string_literal: true

namespace :mail do
  desc "Send email that carrier is due today"
  task due_today_reminder: :environment do
    Loan.due_today.find_each do |loan|
      ReminderMailer.with(mailer_parameters(loan)).due_today_email.deliver_now
    end
  end

  desc "Send email that carrier is due in one week"
  task week_advance_reminder: :environment do
    Loan.due_in_one_week.find_each do |loan|
      ReminderMailer.with(mailer_parameters(loan)).week_advance_notice_email.deliver_now
    end
  end

  desc "Send email that carrier is overdue"
  task overdue_reminder: :environment do
    Loan.overdue.find_each do |loan|
      ReminderMailer.with(mailer_parameters(loan)).overdue_email.deliver_now
    end
  end
end

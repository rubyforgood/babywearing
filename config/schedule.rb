every 1.day do
  # runner "ReminderMailer.overdue_email"
  rake "mail:due_today_reminder"
end

every 1.day do
  rake "mail:week_advance_reminder"
end

every 1.week do
  rake "mail:overdue_reminder"
end
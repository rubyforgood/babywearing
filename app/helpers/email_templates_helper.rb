# frozen_string_literal: true

module EmailTemplatesHelper
  def types_for_select
    [%w[Checkout CheckoutEmailTemplate],
     %w[Reminder ReminderEmailTemplate],
     %w[Welcome WelcomeEmailTemplate]]
  end

  def when_days_display(email_template)
    return 'N/A' unless email_template.is_a?(ReminderEmailTemplate)

    email_template.when_days.to_s
  end

  def when_sent_display(email_template)
    return 'N/A' unless email_template.is_a?(ReminderEmailTemplate)

    email_template.when_sent&.titleize
  end
end

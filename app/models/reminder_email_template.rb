# frozen_string_literal: true

class ReminderEmailTemplate < EmailTemplate
  enum when_sent: { before_due_date: 'before_due_date', after_due_date: 'after_due_date', on_due_date: 'on_due_date' }

  validates_presence_of :when_days, if: :when_days_required?
  validates_presence_of :when_sent

  private

  def when_days_required?
    %w[before_due_date after_due_date].include?(when_sent)
  end
end

# frozen_string_literal: true

require 'email_template_parser'

class ReminderMailer < ApplicationMailer
  def reminder_email(loan, template)
    ActsAsTenant.with_tenant(loan.carrier.organization) do
      return unless template.organization == ActsAsTenant.current_tenant && template.active

      parse_body(loan, template)
      mail(to: loan.borrower.email, from: template.organization.reply_email, subject: template.subject) do |format|
        format.html { render html: @body.html_safe }
      end
    end
  end

  private

  def parse_body(loan, template)
    @body = EmailTemplateParser.new(
      user_name: loan.borrower.first_name,
      carrier_name: loan.carrier.name,
      due_date: loan.due_date
    ).parse_body(template.body)
  end
end

# frozen_string_literal: true

require 'email_template_parser'

class CheckoutMailer < ApplicationMailer
  def checkout_email(loan)
    organization = loan.carrier.organization
    template = CheckoutEmailTemplate.active.where(organization_id: organization.id).last
    return unless template.present?

    build_body(loan, template)
    mail(to: loan.borrower.email, from: organization.reply_email, subject: template.subject) do |format|
      format.html { render html: @body.html_safe }
    end
  end

  private

  def build_body(loan, template)
    @body = EmailTemplateParser.new(
      user_name: loan.borrower.first_name,
      carrier_name: loan.carrier.name,
      due_date: loan.due_date
    ).parse_body(template.body)
  end
end

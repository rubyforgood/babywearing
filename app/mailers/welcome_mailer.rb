# frozen_string_literal: true

require 'email_template_parser'

class WelcomeMailer < CustomMailer
  include Sidekiq::Worker

  def welcome_email(user_id)
    @user = User.find(user_id)
    template = WelcomeEmailTemplate.active.where(organization_id: @user.organization_id).last
    return unless template.present?

    parse_body(template)
    mail(to: @user.email, from: @user.organization.reply_email, subject: template.subject) do |format|
      format.html { render html: @body.html_safe }
    end
  end

  private

  def parse_body(template)
    @body = EmailTemplateParser.new(user_name: @user.first_name).parse_body(template.body)
  end
end

# frozen_string_literal: true

class WelcomeMailer < CustomMailer
  def welcome_email(user_id)
    @user = User.find(user_id)
    @link_url = root_url(host: host, subdomain: subdomain(@user))
    mail(to: @user.email, subject: 'Babywearing Account Registration')
  end

  private

  def host
    Rails.env.development? ? 'lvh.me' : 'babywearing.exchange'
  end

  def subdomain(user)
    mfix = if Rails.env.development? || Rails.application.config.short_server_name == 'prod'
             ''
           else
             Rails.application.config.short_server_name
           end
    [user.organization.subdomain, mfix].reject(&:blank?).join('.')
  end
end

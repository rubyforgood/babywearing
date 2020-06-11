# frozen_string_literal: true

class WelcomeMailer < CustomMailer
  def welcome_email(user)
    @user = user
    @link_url = root_url(host: host(user.organization.subdomain))
    mail(to: @user.email, subject: 'Babywearing Account Registration')
  end

  def host(subdomain)
    mfix = Rails.application.config.short_server_name == 'prod' ? '' : "#{Rails.application.config.short_server_name}."
    "#{subdomain}.#{mfix}babywearing.exchange"
  end
end

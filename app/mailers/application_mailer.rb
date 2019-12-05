# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  helper :application # gives access to all helpers defined within `application_helper`.
  default from: 'stephanie.funk@midatlanticbabywearing.org'
  layout 'mailer'
end

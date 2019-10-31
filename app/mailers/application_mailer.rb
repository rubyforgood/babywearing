# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  helper :application # gives access to all helpers defined within `application_helper`.  
  default from: 'from@example.com'
  layout 'mailer'
end

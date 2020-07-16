Bugsnag.configure do |config|
  config.api_key = "4f5185fc8c82922fc16d39c890e250de"
  config.app_version = Rails.application.config.app_version
  config.auto_notify = Rails.env.production?
    #config.ignore_classes << ActiveRecord::StatementInvalid
end

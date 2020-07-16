require_relative 'boot'

require "rails"
require "csv"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Babywearing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.action_dispatch.rescue_responses["Pundit::NotAuthorizedError"] = :forbidden
    config.action_mailer.delivery_job = "ActionMailer::MailDeliveryJob"

    config.autoload_paths += Dir[Rails.root.join("app", "validators")]

    config.active_job.queue_adapter = :sidekiq

    # this will resolve to stage, stage1, stage2, prod, etc. and is used to set config stuff during provision/deploy
    # and to lookup host-specific keys, etc in credentials
    config.short_server_name = Socket.gethostname.split("-").last
    config.app_version = '0.6001'
  end
end

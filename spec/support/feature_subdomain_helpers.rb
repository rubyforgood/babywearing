# frozen_string_literal: true

module FeatureSubdomainHelpers
  # Sets Capybara to use a given subdomain.
  def within_subdomain(subdomain = 'admin')
    before { Capybara.default_host = "http://#{subdomain}.example.com" }

    after  { Capybara.default_host = 'http://www.example.com' }

    yield
  end
end

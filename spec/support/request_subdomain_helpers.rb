# frozen_string_literal: true

module RequestSubdomainHelpers
  def within_subdomain(subdomain = 'admin')
    before { host! "#{subdomain}.example.com" }

    after  { host! 'www.example.com' }

    yield
  end
end

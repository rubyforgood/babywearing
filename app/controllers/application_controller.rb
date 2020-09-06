# frozen_string_literal: true

require 'modal_responder'

class ApplicationController < ActionController::Base
  before_action :set_tenant_by_subdomain

  include Authentication
  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from Pundit::NotAuthorizedError, with: :render_not_authorized

  before_action :redirect_wrong_tenant, :set_admin_org

  # See `lib/modal_responder.rb` for deatils.
  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder

    respond_with(*args, options, &blk)
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  private

  def current_tenant
    ActsAsTenant.current_tenant
  end

  def redirect_wrong_tenant
    return unless current_user && current_tenant

    redirect_to new_user_session_url if current_user.organization != current_tenant
  end

  def set_admin_org
    @admin_org = ActsAsTenant.current_tenant&.admin?
  end

  def set_tenant_by_subdomain
    subdomain = request.subdomains.first
    return if subdomain.nil?

    tenant = Organization.find_by(subdomain: subdomain)
    ActsAsTenant.current_tenant = tenant
  end

  def render_not_authorized
    render file: "#{Rails.root}/public/422.html", layout: false, status: 401
  end
end

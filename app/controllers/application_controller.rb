# frozen_string_literal: true

require "modal_responder"

class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain(:organization, :subdomain)

  include Authentication
  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :redirect_wrong_tenant, :redirect_notenant, :set_version, :set_admin_org

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

  def redirect_notenant
    redirect_to home_index_path if ActsAsTenant.current_tenant.nil?
  end

  def redirect_wrong_tenant
    return unless current_user && current_tenant

    redirect_to new_user_session_url if current_user.organization != current_tenant
  end

  def set_admin_org
    @admin_org = ActsAsTenant.current_tenant&.admin?
  end

  def set_version
    @version = ""
    fn = File.join(Rails.root, "deploy", "deploy_hash")
    return unless File.exist?(fn)

    @version = File.open(fn, &:gets).strip[0..5]
  end

  def user_not_authorized(_exception)
    flash[:error] = "Sorry, you aren't allowed to do that. You've been redirected to your previous page instead."
    redirect_to(request.referrer || root_path)
  end
end

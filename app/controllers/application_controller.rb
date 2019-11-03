# frozen_string_literal: true

require "modal_responder"

class ApplicationController < ActionController::Base
  include Authentication
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized(_exception)
    flash[:error] = "Sorry, you aren't allowed to do that. You've been redirected to your previous page instead."
    redirect_to(request.referrer || root_path)
  end
end

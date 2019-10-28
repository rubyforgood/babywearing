# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  
private

  def user_not_authorized(exception)
    flash[:error] = "Sorry, you aren't allowed to do that. You've been redirected to your previous page instead."
    redirect_to(request.referrer || root_path)
  end
end

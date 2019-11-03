# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :set_current_user, if: -> { current_user }
  end

  private

  def set_current_user
    Current.user = current_user
  end
end

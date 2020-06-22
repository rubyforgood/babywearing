# frozen_string_literal: true

module UserScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_user
  end

  def set_user
    @user = current_user
  end
end

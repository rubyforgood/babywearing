# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @domain = [request.subdomains.last, request.domain].reject(&:blank?).join('.')
    @organizations = Organization.nonadmin.order(:name)
  end
end

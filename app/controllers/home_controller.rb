# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :redirect_notenant

  def index
    @organizations = Organization.nonadmin.order(:name)
  end
end

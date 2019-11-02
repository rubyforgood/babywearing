# frozen_string_literal: true

class UsersController < ApplicationController
  attr_reader :user

  def index
    @users = authorize User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end
end

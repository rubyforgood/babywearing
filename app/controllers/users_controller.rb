class UsersController < ApplicationController
  attr_reader :user

  def index
    @users = authorize User.all
  end
end

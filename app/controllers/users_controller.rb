class UsersController < ApplicationController

  def index
    @users = User.all
    authorize @users
  end
end

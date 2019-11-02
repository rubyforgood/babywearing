module Users
  class DeactivateController < ApplicationController
    def create
      user = User.find(params[:id])
      user.deactivated? ? user.activate : user.deactivate

      redirect_back(fallback_location: users_path)
    end
  end
end
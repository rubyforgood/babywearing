# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.all
    authorize @users

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def edit
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email, :first_name, :last_name, :street_address, :street_address_second,
      :city, :state, :postal_code, :phone_number, :role
    )
  end
end

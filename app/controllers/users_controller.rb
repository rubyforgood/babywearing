# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]

  def index
    @users = User.page(params[:page])
    authorize @users

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(permitted_attributes(@user))
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  def show
    authorize @user

    @loans = @user.loans
    @memberships = { history: @user.memberships.order(expiration: :desc), current: [@user.current_membership].compact }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

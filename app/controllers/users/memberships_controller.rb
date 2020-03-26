# frozen_string_literal: true

module Users
  class MembershipsController < ApplicationController
    before_action :set_user

    respond_to :html, :json

    def create
      @membership = authorize @user.memberships.new(membership_params)
      if @membership.save
        redirect_to user_path(@user), notice: "Membership successfully created."
      else
        respond_modal_with @membership
      end
    end

    def destroy
      @membership = authorize @user.memberships.find(params[:id])
      if @membership.destroy
        flash[:notice] = "Membership successfully removed."
      end
      redirect_to user_path(@user)
    end

    def edit
      @membership = authorize @user.memberships.find(params[:id])

      respond_modal_with @membership
    end

    def new
      @membership = authorize @user.memberships.build
      respond_modal_with @membership
    end

    def update
      @membership = authorize @user.memberships.find(params[:id])
      if @membership.update(membership_params)
        redirect_to user_path(@user), notice: "Membership successfully updated."
      else
        respond_modal_with @membership
      end
    end

    private

    def membership_params
      params.require(:membership).permit(:id, :membership_type_id, :blocked, :effective, :expiration)
    end

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end

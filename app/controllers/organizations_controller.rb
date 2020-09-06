# frozen_string_literal: true

class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show edit update destroy]

  def index
    @organizations = Organization.order(:name)
  end

  def new
    @organization = Organization.new
  end

  # # GET /categories/1/edit
  # def edit
  # end
  #

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to organization_url(@organization, subdomain: 'admin'),
                  notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_url(@organization, subdomain: 'admin'),
                  notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    destroyed = @organization.destroy

    redirect_to organizations_url(subdomain: 'admin'),
                alert: destroyed ? 'Organization was successfully destroyed.' : 'Could not destroy organization.'
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :subdomain, :email, :reply_email, :phone, :notes, :address,
                                         :city, :state, :zip)
  end
end

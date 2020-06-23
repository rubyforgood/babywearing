# frozen_string_literal: true

module Agreements
  class VersionsController < ApplicationController
    include AgreementScoped

    def create
      @version = authorize @agreement.versions.create(version_params.merge(last_modified_by_id: current_user.id))

      if @version.errors.any?
        flash[:error] = @version.errors.full_messages
        redirect_to new_agreement_version_path(@agreement)
      else
        flash[:success] = 'Version successfully created'
        redirect_to agreement_version_path(@agreement, @version)
      end
    end

    def destroy
      @version = authorize @agreement.versions.find(params[:id])

      if @version.destroy
        flash[:notice] = 'Version successfully deleted.'
        redirect_to agreement_path(@agreement)
      else
        flash[:error] = @version.errors.full_messages
        redirect_to agreement_version_path(@agreement, @version)
      end
    end

    def edit
      @version = authorize @agreement.versions.find(params[:id])
    end

    def index
      @versions = authorize @agreement.versions
    end

    def new
      @version = authorize @agreement.versions.build
      @version.copy_content
    end

    def show
      @version = authorize @agreement.versions.find(params[:id])
    end

    def update
      @version = authorize @agreement.versions.find(params[:id])
      if @version.update(version_params.merge(last_modified_by_id: current_user.id))
        redirect_to agreement_version_path(@agreement, @version), notice: 'Version successfully updated.'
      else
        flash[:error] = @version.errors.full_messages
        redirect_to edit_agreement_version_path(@agreement, @version)
      end
    end

    private

    def version_params
      params.require(:agreement_version).permit(:title, :content, :version, :active)
    end
  end
end

# frozen_string_literal: true

module Users
  class SignaturesController < ApplicationController
    include UserScoped

    def create
      @signature = @user.signatures.new(signature_params.merge(signed_at: Time.zone.now))
      if @signature.save
        redirect_to user_signatures_path(@user), notice: 'Agreement successfully signed.'
      else
        flash[:error] = @signature.errors.full_messages
        redirect_to(new_user_signature_path(@user, agreement_version_id: params[:agreement_version_id]))
      end
    end

    def index
      @signatures = @user.active_signatures
      @unsigned_agreements = @user.unsigned_agreements
    end

    def new
      @signature = @user.signatures.build(agreement_version_id: params[:agreement_version_id])
    end

    private

    def signature_params
      params.require(:signature).permit(:id, :agreement_version_id, :signature)
    end
  end
end

class PhotosController < ApplicationController
  def destroy
    @photo = ActiveStorage::Attachment.find(params[:id])
    carrier = @photo.record
    @photo.purge
    flash[:success] = 'Photo successfully destroyed'
    redirect_to edit_carrier_path(carrier)
  end
end

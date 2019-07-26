class AgreementsController < ApplicationController
  before_action :set_agreement, only: [:show, :edit, :update, :destroy]


  def index
    @agreements = Agreement.all
  end

  def show

  end


  private 

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end
end

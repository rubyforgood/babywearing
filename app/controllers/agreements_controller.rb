class AgreementsController < ApplicationController
  before_action :set_agreement, only: [:show, :edit, :update, :destroy]


  def index
    @agreements = Agreement.all
  end

  def show

  end

  def new
    @agreement = Agreement.new
  end

  def create
    @agreement = Agreement.new(agreement_params)
    @agreement.save
    redirect_to agreement_path(@agreement)
  end


  private 

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def agreement_params
    params.require(:agreement).permit(:title, :content)
  end
end

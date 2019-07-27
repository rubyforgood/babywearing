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

  def destroy
    @agreement.destroy
    respond_to do |format|
      format.html { redirect_to agreements_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private 

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def agreement_params
    params.require(:agreement).permit(:title, :content)
  end
end

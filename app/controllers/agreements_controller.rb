class AgreementsController < ApplicationController

  def index
    @agreements = Agreement.all
  end

  
end

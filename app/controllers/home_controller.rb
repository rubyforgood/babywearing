class HomeController < ApplicationController

  def inventory
    # binding.pry
    #how do I get organization_id?
    # @organization = Organization.find_by(id: params[:organization_id])
    
    render 'organizations/show'
  end
end

require 'rails_helper'

RSpec.describe 'Destroy an organization', type: :feature do
  scenario 'destroy button is clicked on organization index page' do
    @organization = Organization.new(name: 'Henrys Baby Hammocks', description: 'Hammocks for the babiez')
    @organization.save!

    visit organizations_path
    click_link 'Destroy'
  
    expect(page).to have_content('Organization was successfully destroyed.')
  end
end
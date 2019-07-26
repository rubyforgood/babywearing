require 'rails_helper'

RSpec.describe 'Show an organization', type: :feature do
  scenario 'click on show of organization index page' do
    @organization = Organization.new(name: 'Henrys Baby Hammocks', description: 'Hammocks for the babiez')
    @organization.save!

    visit organizations_path
    click_link 'Show'
  
    expect(page).to have_content('Henrys Baby Hammocks')
    expect(page).to have_content('Hammocks for the babiez')
  end
end
require 'rails_helper'

RSpec.describe 'Editing an organization', type: :feature do
  before(:each) do
    @organization = Organization.new(name: 'Henrys Baby Hammocks', description: 'Hammocks for the babiez')
    @organization.save!
  end
  scenario 'all expected information is given' do
    visit edit_organization_path(@organization.id)
    fill_in 'Name', with: 'Fake Organization'
    fill_in 'Description', with: 'Desciption of Fake Organization'
    click_on 'Update Organization'
    expect(page).to have_content('Organization was successfully updated.')
    expect(page).to have_content('Fake Organization')
    expect(page).to have_content('Desciption of Fake Organization')
  end

  scenario 'name is NOT given' do
    visit edit_organization_path(@organization.id)
    fill_in 'Name', with: nil
    click_on 'Update Organization'
    expect(page).to have_content("Name can't be blank")
  end
end
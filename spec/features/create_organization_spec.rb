require 'rails_helper'

RSpec.describe 'Creating a new organization', type: :feature do
  scenario 'all expected information is given' do
    visit organizations_path
    click_link('New Organization')
    fill_in 'Name', with: 'Fake Organization'
    fill_in 'Description', with: 'Desciption of Fake Organization'
    click_on 'Create Organization'
    expect(page).to have_content('Organization was successfully created.')
  end

  scenario 'name is not given' do
    visit organizations_path
    click_link('New Organization')
    fill_in 'Name', with: nil
    fill_in 'Description', with: 'Desciption of Fake Organization'
    click_on 'Create Organization'
    expect(page).to have_content("Name can't be blank")
  end
end
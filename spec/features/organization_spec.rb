require 'rails_helper'

RSpec.describe 'Organization', type: :feature do
  fixtures :users
  let(:user) { users(:user) }

  before(:each) do
    visit "/"
    sign_in user

    @organization = Organization.new(name: 'Henrys Baby Hammocks', description: 'Hammocks for the babies')
    @organization.save!
  end

  scenario 'SHOW' do
    visit organizations_path
    click_link 'Show'
  
    expect(page).to have_content('Henrys Baby Hammocks')
    expect(page).to have_content('Hammocks for the babies')
  end

  scenario 'EDIT when name is NOT given' do
    visit edit_organization_path(@organization.id)

    fill_in 'Name', with: nil
    click_on 'Update Organization'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'EDIT when all expected information is given' do
    visit edit_organization_path(@organization.id)

    fill_in 'Name', with: 'Fake Organization'
    fill_in 'Description', with: 'Desciption of Fake Organization'
    click_on 'Update Organization'

    expect(page).to have_content('Organization was successfully updated.')
    expect(page).to have_content('Fake Organization')
    expect(page).to have_content('Desciption of Fake Organization')
  end

  scenario 'DESTROY when delete button is clicked' do
    visit organizations_path
    click_link 'Destroy'
  
    expect(page).to have_content('Organization was successfully destroyed.')
  end

  scenario 'CREATE when name is NOT given' do
    visit organizations_path

    click_link('New Organization')
    fill_in 'Name', with: nil
    fill_in 'Description', with: 'Desciption of Fake Organization'
    click_on 'Create Organization'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'CREATE when all expected information is given' do
    visit organizations_path

    click_link('New Organization')
    fill_in 'Name', with: 'Fake Organization'
    fill_in 'Description', with: 'Desciption of Fake Organization'
    click_on 'Create Organization'

    expect(page).to have_content('Organization was successfully created.')
  end
end
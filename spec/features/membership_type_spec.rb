# frozen_string_literal: true

RSpec.describe 'MembershipType', type: :feature do
  fixtures :users
  let(:user) { users(:user) }

  before(:each) do
    visit "/"
    sign_in user
    @membership_type = MembershipType.new(
      name: 'Annual',
      fee_cents: 30_00, 
      duration_days: 3,
      number_of_items: 3,
      description: "A text description goes here.")
    @membership_type.save!
  end

  scenario 'SHOW' do
    visit "/membership_types"
    expect(page).to have_content('New Membership Type')
  end

  scenario 'EDIT when name is NOT given' do
    visit edit_membership_type_path(@membership_type.id)

    fill_in 'Name', with: ""
    click_on 'Update Membership type'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'EDIT when all expected information is given' do
    visit edit_membership_type_path(@membership_type.id)

    fill_in 'Name', with: 'Trial'
    fill_in 'Description', with: 'This is a trial membership'
    click_on 'Update Membership type'

    expect(page).to have_content('Membership type was successfully updated.')
  end

  scenario 'DESTROY when delete button is clicked' do
    visit membership_types_path
    click_link 'Destroy'
  
    expect(page).to have_content('Membership type was successfully destroyed.')
  end

  scenario 'CREATE when name is NOT given' do
    visit membership_types_path
    click_link('New Membership Type')
    fill_in 'Name', with: ""
    click_on 'Create Membership type'
    expect(page).to have_content("Name can't be blank")
  end

  scenario 'CREATE when all expected information is given' do
    visit membership_types_path

    click_link('New Membership Type')
    fill_in 'Name', with: 'Trial'
    fill_in 'Description', with: 'A text description goes here.'
    fill_in 'Duration', with: 2
    fill_in 'Number of items', with: 3
    fill_in 'Fee', with: 4
    click_on 'Create Membership type'

    expect(page).to have_content('Membership type was successfully created.')
  end
end

# frozen_string_literal: true

RSpec.feature "fee_type" do
  let(:user) { users(:admin) }
  let(:fee_type) { fee_types(:upgrade) }

  before :each do
    visit "/"
    sign_in user
  end

  scenario 'SHOW' do
    visit fee_types_path
    click_link fee_type.name

    expect(page).to have_content(fee_type.name)
    expect(page).to have_content("20.00")
  end

  scenario 'EDIT when name is NOT given' do 
    visit edit_fee_type_path(fee_type)

    fill_in 'Name', with: nil
    click_on 'Update Fee type'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'EDIT when all expected information is given' do 
    visit edit_fee_type_path(fee_type)

    fill_in 'Name', with: 'Updated Membership'
    fill_in 'Amount', with: '3000'
    click_on 'Update Fee type'

    expect(page).to have_content('Fee type was successfully updated.')
    expect(page).to have_content('Updated Membership')
    expect(page).to have_content('30.00')
  end

  scenario 'DESTROY when delete button is clicked' do 
    visit fee_types_path
    click_link 'Destroy'

    expect(page).to have_content('Fee type was successfully destroyed.')
  end

  scenario 'CREATE when name is NOT given' do 
    visit fee_types_path

    click_link('+ New')
    fill_in 'Name', with: nil
    fill_in 'Amount', with: '4000'
    click_on 'Create Fee type'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'CREATE when all expected information is given' do 
    visit fee_types_path

    click_link('+ New')
    fill_in 'Name', with: 'Upgrade Membership'
    fill_in 'Amount', with: '3000'
    click_on 'Create Fee type'

    expect(page).to have_content('Fee type was successfully created.')
  end
end

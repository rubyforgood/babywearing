# frozen_string_literal: true

RSpec.describe 'Carrier USER role' do
  let(:carrier) { carriers(:carrier) }
  let(:user) { users(:user) }

  before do
    visit '/'
    sign_in user
  end

  scenario 'SHOW' do
    visit carriers_path
    click_link carrier.name

    expect(page).to have_content('test carrier')
    expect(page).to have_content('babywearing')
    expect(page).to have_content('test model')
  end

  scenario 'NEW' do
    visit new_carrier_path

    expect(page).to have_content "Sorry, you aren't allowed to do that."
  end

  scenario 'EDIT' do
    visit edit_carrier_path(carrier.id)

    expect(page).to have_content "Sorry, you aren't allowed to do that."
  end

end

RSpec.describe 'Carrier ADMIN role' do
  let(:category) { categories(:category) }
  let(:washington) { locations(:washington) }
  let(:lancaster) { locations(:lancaster) }
  let(:carrier) { carriers(:carrier) }
  let(:user) { users(:admin) }

  before do
    visit '/'
    sign_in user
  end

  scenario 'SHOW' do
    visit carriers_path
    click_link carrier.name

    expect(page).to have_content('test carrier')
    expect(page).to have_content('babywearing')
    expect(page).to have_content('test model')
  end

  scenario 'NEW' do
    visit new_carrier_path
    expect(page).to have_content('New Carrier')
    expect(page).to have_content('Name')
    expect(page).to have_content('Item')
    expect(page).to have_content('Manufacturer')
    expect(page).to have_content('Model')
    expect(page).to have_content('Color')
    expect(page).to have_content('Safety Link')

    expect(current_path).to eq '/carriers/new'
  end

  scenario 'EDIT with all required fields' do
    visit edit_carrier_path(carrier.id)

    fill_in 'Name', with: 'Updated Name'
    fill_in 'Model', with: 'Updated Model'
    find('#carrier_current_location_id').find(:option, lancaster.name).select_option
    click_on 'Update Carrier'

    expect(page).to have_content('Updated Name')
    expect(page).to have_content('Updated Model')
    expect(page).to have_content('Lancaster')
  end

  scenario 'EDIT without any required fields' do
    visit edit_carrier_path(carrier.id)

    fill_in 'Name', with: nil
    fill_in 'Item', with: nil
    click_on 'Update Carrier'

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Item can\'t be blank')
  end

  scenario 'DESTROY' do
    visit carrier_path(carrier.id)

    click_on 'Delete'
    expect(page).to have_content('Carrier successfully destroyed')
  end

  scenario 'CREATE with all required fields' do
    visit new_carrier_path
    fill_in 'Name', with: 'Test Name'
    fill_in 'Item', with: 9
    fill_in 'Manufacturer', with: 'Test Manufacturer'
    fill_in 'Model', with: 'Test Model'
    fill_in 'Color', with: 'White'
    find('#carrier_category_id').find(:option, category.name).select_option

    click_on 'Create Carrier'

    expect(page).to have_content('Carrier successfully created')
  end

  scenario 'CREATE with duplicated item_id' do
    visit new_carrier_path
    fill_in 'Item', with: carrier.item_id

    click_on 'Create Carrier'

    expect(page).to have_content('Item ID has already been taken')
  end

  scenario 'CREATE without required fields' do
    visit new_carrier_path(carrier.id)

    click_on 'Create Carrier'

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Item can\'t be blank')
  end

  scenario 'ADD new carrier' do
    visit '/'
    click_on 'ADD ITEM'

    expect(page).to have_content('New Carrier')
    expect(page).to have_content('Name')
    expect(page).to have_content('Item')
    expect(page).to have_content('Manufacturer')
    expect(page).to have_content('Model')
    expect(page).to have_content('Color')

    expect(current_path).to eq '/carriers/new'
  end
end

RSpec.describe 'Carrier VOLUNTEER role' do
  let(:category) { categories(:category) }
  let(:washington) { locations(:washington) }
  let(:lancaster) { locations(:lancaster) }
  let(:carrier) { carriers(:carrier) }
  let(:user) { users(:volunteer) }

  before do
    visit '/'
    sign_in user
  end

  scenario 'NEW' do
    visit new_carrier_path

    expect(page).to have_content('New Carrier')
    expect(page).to have_content('Name')
    expect(page).to have_content('Item')
    expect(page).to have_content('Manufacturer')
    expect(page).to have_content('Model')
    expect(page).to have_content('Color')

    expect(current_path).to eq '/carriers/new'
  end

  scenario 'SHOW' do
    visit carriers_path
    click_link carrier.name

    expect(page).to have_content('test carrier')
    expect(page).to have_content('babywearing')
    expect(page).to have_content('test model')
  end

  scenario 'EDIT with all required fields' do
    visit edit_carrier_path(carrier.id)

    fill_in 'Name', with: 'Updated Name'
    fill_in 'Model', with: 'Updated Model'
    find('#carrier_current_location_id').find(:option, lancaster.name).select_option
    click_on 'Update Carrier'

    expect(page).to have_content('Updated Name')
    expect(page).to have_content('Updated Model')
    expect(page).to have_content('Lancaster')
  end

  scenario 'EDIT without any required fields' do
    visit edit_carrier_path(carrier.id)

    fill_in 'Name', with: nil
    fill_in 'Item', with: nil
    click_on 'Update Carrier'

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Item can\'t be blank')
  end

  scenario 'DESTROY' do
    visit carrier_path(carrier.id)

    click_on 'Delete'
    expect(page).to have_content('Carrier successfully destroyed')
  end

  scenario 'CREATE with all required fields' do
    visit new_carrier_path
    fill_in 'Name', with: 'Test Name'
    fill_in 'Item', with: 9
    fill_in 'Manufacturer', with: 'Test Manufacturer'
    fill_in 'Model', with: 'Test Model'
    fill_in 'Color', with: 'White'
    find('#carrier_category_id').find(:option, category.name).select_option

    click_on 'Create Carrier'

    expect(page).to have_content('Carrier successfully created')
  end

  scenario 'CREATE with duplicated item_id' do
    visit new_carrier_path
    fill_in 'Item', with: carrier.item_id

    click_on 'Create Carrier'

    expect(page).to have_content('Item ID has already been taken')
  end

  scenario 'CREATE without required fields' do
    visit new_carrier_path(carrier.id)

    click_on 'Create Carrier'

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Item can\'t be blank')
  end

  scenario 'ADD new carrier' do
    visit '/'
    click_on 'ADD ITEM'

    expect(page).to have_content('New Carrier')
    expect(page).to have_content('Name')
    expect(page).to have_content('Item')
    expect(page).to have_content('Manufacturer')
    expect(page).to have_content('Model')
    expect(page).to have_content('Color')

    expect(current_path).to eq '/carriers/new'
  end
end

RSpec.describe 'Carrier MEMBER role' do
  let(:carrier) { carriers(:carrier) }
  let(:user) { users(:member) }

  before do
    visit '/'
    sign_in user
  end

  scenario 'SHOW' do
    visit carriers_path
    click_link carrier.name

    expect(page).to have_content('test carrier')
    expect(page).to have_content('babywearing')
    expect(page).to have_content('test model')
  end

  scenario 'NEW' do
    visit new_carrier_path

    expect(page).to have_content "Sorry, you aren't allowed to do that."
  end

  scenario 'EDIT' do
    visit edit_carrier_path(carrier.id)

    expect(page).to have_content "Sorry, you aren't allowed to do that."
  end

end

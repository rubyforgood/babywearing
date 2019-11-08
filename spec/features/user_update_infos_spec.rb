# frozen_string_literal: true

RSpec.describe 'User update information', type: :feature do
  let!(:user) { users(:user) }

  scenario 'checking the fields before update' do
    sign_in_with email: user.email, password: 'password'
    user_should_be_signed_in
    visit(edit_user_registration_path)
    expect(page).to have_field('First name', with: user.first_name)
    expect(page).to have_field('Last name', with: user.last_name)
  end

  scenario 'valid attributes' do
    sign_in_with email: user.email, password: 'password'
    user_should_be_signed_in
    visit(edit_user_registration_path)
    expect(page).to have_content('Edit User')
    fill_in('Current password', with: 'password')
    fill_in('First name', with: 'New first name')
    fill_in('Last name', with: 'New last name')
    click_button("Update")
    expect(page).to have_content('Your account has been updated successfully.')
    visit(edit_user_registration_path)
    expect(page).to have_field('First name', with: 'New first name')
    expect(page).to have_field('Last name', with: 'New last name')
  end

  scenario 'invalid attributes' do
    sign_in_with email: user.email, password: 'password'
    user_should_be_signed_in
    visit(edit_user_registration_path)
    expect(page).to have_content('Edit User')
    fill_in('Current password', with: '')
    fill_in('First name', with: 'New first name')
    fill_in('Last name', with: 'New last name')
    click_button("Update")
    expect(page).to have_content("Current password can't be blank")
  end
end

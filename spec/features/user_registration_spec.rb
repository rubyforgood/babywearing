# frozen_string_literal: true

RSpec.feature 'user registration' do
  it 'allows user to create a user account' do
    visit root_url
    find_link('Sign Up', match: :first).click
    fill_in 'Enter email address', with: 'alicia@gmail.com'
    fill_in 'Password', with: 'just4now'
    fill_in 'Confirm Password', with: 'just4now'
    fill_in 'First name', with: 'me'
    fill_in 'Last name', with: 'last'
    fill_in 'Street address', with: '123 main street'
    fill_in 'City', with: 'fairfax'
    fill_in 'State', with: 'VA'
    fill_in 'Postal code', with: '22032'
    fill_in 'Phone', with: '8008885555'
    click_button 'Sign Up'
    expect(page).to have_content('Welcome! You have signed up successfully.', count: 1)
  end

  context 'when the email is invalid' do
    it 'does not allow user to create a user account' do
      visit root_url
      find_link('Sign Up', match: :first).click
      fill_in 'Enter email address', with: 'alicia.email.com'
      fill_in 'Password', with: 'just4now'
      fill_in 'Confirm Password', with: 'just4now'
      click_button 'Sign Up'
      expect(page).to have_content 'Email is invalid'
    end
  end
end

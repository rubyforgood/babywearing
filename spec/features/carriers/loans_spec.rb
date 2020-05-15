# frozen_string_literal: true

RSpec.feature 'Loan spec', type: :feature do
  let(:admin)     { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:borrower)  { users(:borrower) }
  let(:carrier)   { carriers(:carrier) }

  scenario "Member can't create perform checkout" do
    sign_in borrower
    visit carrier_url(carrier)
    expect(page).to have_no_link('Checkout')
  end

  scenario 'Admin can create a new checkout' do
    sign_in admin
    visit carrier_url(carrier)

    click_link 'Checkout'
    select borrower.name, from: 'loan_borrower_id'
    click_on 'Checkout'

    expect(page).to have_current_path(carrier_path(carrier))
    expect(page).to have_content('Checked Out')
  end

  scenario 'Volunteer can create a new checkout' do
    sign_in volunteer
    visit carrier_url(carrier)

    click_link 'Checkout'
    select borrower.name, from: 'loan_borrower_id'
    click_on 'Checkout'

    expect(page).to have_current_path(carrier_path(carrier))
    expect(page).to have_content('Checked Out')
  end

  scenario 'User is not able to perform checkout if carrier is not available' do
    sign_in admin
    visit carrier_url(carriers(:unavailable))
    expect(page).not_to have_selector(:link_or_button, 'Checkout')
  end
end

# frozen_string_literal: true

RSpec.feature 'Loan spec', type: :feature do
  let(:admin)     { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:member)    { users(:member) }
  let(:carrier)   { carriers(:carrier) }

  scenario "Member can't create perform checkout" do
    sign_in member
    visit carrier_url(carrier)
    expect(page).to have_no_link('Checkout')
  end

  scenario 'Admin can create a new checkout' do
    sign_in admin
    visit carrier_url(carrier)

    click_link "Checkout"
    select member.name, from: "loan_member_id"
    click_on "Checkout"

    expect(page).to have_current_path(carrier_path(carrier))
  end

  scenario 'Volunteer can create a new checkout' do
    sign_in volunteer
    visit carrier_url(carrier)

    click_link "Checkout"
    select member.name, from: "loan_member_id"
    click_on "Checkout"

    expect(page).to have_current_path(carrier_path(carrier))
  end
end

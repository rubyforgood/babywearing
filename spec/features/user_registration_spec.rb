# frozen_string_literal: true

RSpec.feature "user registration" do
  scenario "should allow user to create a user account" do
    visit "/"
    find_link("Sign up", match: :first).click
    fill_in "Email", with: "alicia@gmail.com"
    fill_in "Password", with: "just4now"
    fill_in "Password confirmation", with: "just4now"
    fill_in "First name", with: "me"
    fill_in "Last name", with: "last"
    fill_in "Street address", with: "123 main street"
    fill_in "City", with: "fairfax"
    fill_in "State", with: "VA"
    fill_in "Postal code", with: "22032"
    fill_in "Phone number", with: "8008885555"
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.", count: 1)
  end

  context "when the email is invalid" do
    scenario "should NOT allow user to create a user account" do
      visit "/"
      find_link("Sign up", match: :first).click
      fill_in "Email", with: "alicia.email.com"
      fill_in "Password", with: "just4now"
      fill_in "Password confirmation", with: "just4now"
      click_button "Sign up"
      expect(page).to have_content "Email is invalid"
    end
  end
end

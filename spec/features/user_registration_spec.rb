require 'rails_helper'

RSpec.feature "user registration", type: :feature do
  scenario "should allow user to create a user account" do
    visit "/"
    find_link("Sign up", match: :first).click
    fill_in "Email", with: "alicia@gmail.com"
    fill_in "Password", with: "just4now"
    fill_in "Password confirmation", with: "just4now"
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "should allow user to create a user account" do
    visit "/"
    find_link("Sign up", match: :first).click
    fill_in "Email", with: "alicia.email.com"
    fill_in "Password", with: "just4now"
    fill_in "Password confirmation", with: "just4now"
    click_button "Sign up"
    expect(page).to have_content "Email is invalid"
  end
end
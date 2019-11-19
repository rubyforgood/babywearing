# frozen_string_literal: true

RSpec.describe 'Visitor signs in', type: :feature do
  let(:user) { users(:member) }
  let(:valid_password) { 'password' }

  scenario "with valid email and password" do
    sign_in_with email: user.email, password: valid_password
    user_should_be_signed_in
  end

  scenario "with invalid email" do
    sign_in_with email: "invalid.email@exmaple.org", password: valid_password
    user_should_be_signed_out
    expect(page).to have_content "Invalid Email/Password."
  end

  scenario "with invalid password" do
    sign_in_with email: user.email, password: "invalid_password"
    user_should_be_signed_out
    expect(page).to have_content "Invalid Email/Password."
  end
end

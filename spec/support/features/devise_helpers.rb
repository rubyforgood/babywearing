# frozen_string_literal: true

module Features
  def sign_in_with(email:, password:)
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button "Log In"
  end

  def user_sign_out
    click_link "Logout"
  end

  def user_should_be_signed_in
    visit root_path
    expect(page).to have_content "Logout"
  end

  def user_should_be_signed_out
    expect(page).to have_content "Log In"
  end
end

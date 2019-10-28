# frozen_string_literal: true

RSpec.describe 'User signs out', type: :feature do
  scenario "signs out" do
    user = users(:member)
    sign_in user
    visit root_url

    user_sign_out

    user_should_be_signed_out
  end
end

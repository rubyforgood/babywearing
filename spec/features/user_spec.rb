# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "User" do

  fixtures :users
  let(:user) { users(:user) }

  scenario "should allow user who is an admin to see list of users" do
    user.add_role :admin
    sign_in user
    visit "/users"
    expect(page).to have_content "User Listing"
  end

  scenario "should allow user who is a volunteer to see list of users" do
    user.add_role :volunteer
    sign_in user
    visit "/users"
    expect(page).to have_content "User Listing"
  end

  scenario "should not allow user who is not a volunteer or admin to see list of users" do
    user.add_role :member
    sign_in user
    visit "/users"
    expect(page).to have_content "Sorry, you aren't allowed to do that."
  end

  scenario "should allow user who is an admin to export list of users" do
    user.add_role :admin
    sign_in user
    visit "/users"
    click_on 'Export to CSV'
    header = page.response_headers['Content-Disposition']
    expect(header).to match "attachment; filename=\"users-#{Date.today}.csv\""
  end

  scenario "should allow user who is a volunteer to export list of users" do
    user.add_role :volunteer
    sign_in user
    visit "/users"
    click_on 'Export to CSV'
    header = page.response_headers['Content-Disposition']
    expect(header).to match "attachment; filename=\"users-#{Date.today}.csv\""
  end

  scenario "should send the user a welcome email" do
    Devise.mailer.deliveries = [] 

    user = User.create(
      email: "alicia@test.com",
      password: "123abc",
      full_name: "Alicia Barrett",
      street_address: "123 street",
      city: "Atlanta",
      state: "GA",
      postal_code: "30030",
      phone_number: "909-851-9806"
    )

    aggregate_failures "testing welcome email" do
      expect(Devise.mailer.deliveries.count).to eq 1
      expect(Devise.mailer.deliveries.first.subject).to eq "Babywearing Account Registration"
      expect(Devise.mailer.deliveries.first.to).to include(user.email)
    end
  end
end

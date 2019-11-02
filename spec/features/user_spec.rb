# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "User" do
  let(:admin) { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:member) { users(:member) }

  scenario "should allow user who is an admin to see list of users" do
    sign_in admin
    visit users_url
    expect(page).to have_content "User Listing"
  end

  scenario "should allow user who is a volunteer to see list of users" do
    sign_in volunteer
    visit users_url
    expect(page).to have_content "User Listing"
  end

  scenario "should not allow user who is not a volunteer or admin to see list of users" do
    sign_in member
    visit users_url
    expect(page).to have_content "Sorry, you aren't allowed to do that."
  end

  scenario "should allow user who is an admin to export list of users" do
    sign_in admin

    visit users_url
    click_on 'Export to CSV'

    header = page.response_headers['Content-Disposition']
    expect(header).to match "attachment; filename=\"users-#{Date.today}.csv\""
  end

  scenario "should allow user who is a volunteer to export list of users" do
    sign_in volunteer

    visit users_url
    click_on 'Export to CSV'

    header = page.response_headers['Content-Disposition']
    expect(header).to match "attachment; filename=\"users-#{Date.today}.csv\""
  end

  scenario "user should be able to log out" do
    sign_in member

    visit root_url
    find('.user-dropdown').click
    click_on "Logout"

    expect(page).to have_content "Log in"
  end

  scenario 'should allow user who is an admin to see memebers tile on header' do
    sign_in admin
    visit root_url
    expect(page).to have_content "VIEW MEMBERS"
  end

  scenario 'should allow user who is a volunteer to see memebers tile on header' do
    sign_in volunteer
    visit root_url
    expect(page).to have_content "VIEW MEMBERS"
  end

  scenario 'should not allow user who is a member to see memebers tile on header' do
    sign_in member
    visit root_url
    expect(page).not_to have_content "VIEW MEMBERS"
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

  scenario 'should allow an admin to activate and deactivate a user'do
    sign_in admin
    visit users_url

    deactive_links  = all('a').select { |l| l.text == "Deactivate" }
    activated_links = all('a').select { |l| l.text == "Activate" }
    expect(deactive_links.count).to eq(4)
    expect(activated_links.count).to eq(0)

    all('a').select { |l| l.text == "Deactivate" }.last.click
    deactive_links   = all('a').select { |l| l.text == "Deactivate" }
    activated_links  = all('a').select { |l| l.text == "Activate" }
    expect(deactive_links.count).to eq(3)
    expect(activated_links.count).to eq(1)

    all('a').select { |l| l.text == "Activate" }.last.click
    deactive_links  = all('a').select { |l| l.text == "Deactivate" }
    activated_links = all('a').select { |l| l.text == "Activate" }
    expect(deactive_links.count).to eq(4)
    expect(activated_links.count).to eq(0)
  end
end

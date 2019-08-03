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
    expect(header).to match "attachment; filename=\"users-2019-08-03.csv\""
  end

  scenario "should allow user who is a volunteer to export list of users" do
    user.add_role :volunteer
    sign_in user
    visit "/users"
    click_on 'Export to CSV'
    header = page.response_headers['Content-Disposition']
    expect(header).to match "attachment; filename=\"users-2019-08-03.csv\""
  end
end
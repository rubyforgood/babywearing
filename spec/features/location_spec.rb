# frozen_string_literal: true

RSpec.describe Location, type: :feature do
  let(:user) { users(:admin) }

  # TODO: add tests to make sure if you're not logged in as an admin,
  # you can't do these things to a location

  before do
    visit "/"
    sign_in user
  end

  scenario 'should allow admin to CREATE new locations' do
    visit "/locations"
    find_link("+ New", match: :first).click
    fill_in "Name", with: "Bellvue"
    click_button "Create Location"
    expect(page).to have_content "Bellvue"

    visit "/locations"
    find_link("+ New", match: :first).click
    fill_in "Name", with: "Robinson"
    click_button "Create Location"
    expect(page).to have_content "Robinson"
  end

  scenario 'should allow admin to UPDATE a location' do
    visit "/locations"
    find_link("+ New", match: :first).click
    fill_in "Name", with: "Robinson"
    click_button "Create Location"
    expect(page).to have_content "Robinson"
    find_link("Edit this location").click
    fill_in "Name", with: "New location"
    click_button "Update Location"
    expect(page).to have_content "New location"
  end

  scenario 'should allow admin to DELETE a location' do
    visit "/locations"
    find_link("+ New", match: :first).click
    fill_in "Name", with: "Bridgeville"
    click_button "Create Location"
    expect(page).to have_content "Bridgeville"
    find_link("Delete this location").click
    expect(page).not_to have_content "Location was successfully deleted."
  end
end

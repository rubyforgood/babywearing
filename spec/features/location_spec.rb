# frozen_string_literal: true

RSpec.feature 'create a location', type: :feature do
  let(:user) { users(:admin) }

  before :each do
    visit "/"
    sign_in user
  end

  scenario 'should allow admin to create a new location' do
    visit "/locations"
    find_link("+ New", match: :first).click
    fill_in "Name", with: "Bellvue"
    click_button "Create Location"
    expect(page).to have_content "Bellvue"
  end

  scenario 'should allow admin to create a new location' do
    visit "/locations"
    find_link("+ New", match: :first).click
    fill_in "Name", with: "Robinson"
    click_button "Create Location"
    expect(page).to have_content "Robinson"
  end

  scenario 'should allow admin to update a location' do
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

  scenario 'should allow adming to delete a location' do
    visit "/locations"
    find_link("+ New", match: :first).click
    fill_in "Name", with: "Bridgeville"
    click_button "Create Location"
    expect(page).to have_content "Bridgeville"
    find_link("Delete this location").click
    expect(page).not_to have_content "Location was successfully deleted."
  end
end

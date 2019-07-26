require 'rails_helper'

RSpec.feature 'create a location', type: :feature do 
  scenario 'should allow admin to create a new location' do
    visit "/locations"
    find_link("Add a new location", match: :first).click
    fill_in "name", with: "Bellvue"
    click_button "Create Location"
    expect(page).to have_content "Bellvue"
  end

  scenario 'should allow admin to create a new location' do
    visit "/locations"
    find_link("Add a new location", match: :first).click
    fill_in "name", with: "Robinson"
    click_button "Create Location"
    expect(page).to have_content "Robinson"
  end
end
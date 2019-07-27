RSpec.feature 'create a location', type: :feature do
  fixtures :users
  let(:user) { users(:user) }

  before :each do
    Organization.create name: "Ruby For Good"
    visit "/"
    sign_in user
  end

  scenario 'should allow admin to create a new location' do
    visit "/locations"
    find_link("Add a new location", match: :first).click
    fill_in "name", with: "Bellvue"
    select "Ruby For Good", from: "location_organization_id"
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

  scenario 'should allow admin to update a location' do
    visit "/locations"
    find_link("Add a new location", match: :first).click
    fill_in "name", with: "Robinson"
    click_button "Create Location"
    expect(page).to have_content "Robinson"
    find_link("Edit this location").click
    fill_in "name", with: "New location"
    click_button "Update Location"
    expect(page).to have_content "New location"
  end

  scenario 'should allow adming to delete a location' do
    visit "/locations"
    find_link("Add a new location", match: :first).click
    fill_in "name", with: "Bridgeville"
    click_button "Create Location"
    expect(page).to have_content "Bridgeville"
    find_link("Delete this location").click
    expect(page).not_to have_content "New location"
  end
end

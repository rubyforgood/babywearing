# frozen_string_literal: true

RSpec.feature "category" do
  fixtures :categories
  let!(:category) { categories(:category) }
  fixtures :users
  let(:user) { users(:user) }

  before :each do
    visit "/"
    sign_in user
  end

  scenario "should allow user to create a category" do
    visit "/categories"
    find_link("New Category").click
    fill_in "Name", with: "pineapple"
    fill_in "Description", with: "sweet"
    fill_in "Parent", with: "1"
    click_button "Create Category"
    expect(page).to have_content "Category was successfully created."
  end

  scenario "should allow user to update a category" do
    visit "/categories"
    find_link("Show").click
    expect(page).to have_content category.name
    find_link("Edit").click
    fill_in "Name", with: "orange"
    click_button "Update Category"
    expect(page).to have_content "Category was successfully updated."
    expect(page).to have_content "orange"
  end

  scenario "should allow user to delete a category" do
    visit "/categories"
    expect(page).to have_content category.name
    find_link("Destroy").click
    expect(page).to have_content "Category was successfully destroyed."
  end
end

# frozen_string_literal: true

RSpec.feature "category" do
  let!(:category) { categories(:category_parent) }
  let!(:category_child) { categories(:category) }
  let!(:carrier) { carriers(:carrier) }
  let(:user) { users(:admin) }

  before :each do
    visit "/"
    sign_in user
  end

  scenario "should allow user to create a category" do
    visit "/categories"
    find_link("+ New").click
    fill_in "Name", with: "pineapple"
    fill_in "Description", with: "sweet"
    fill_in "Parent", with: "1"
    click_button "Create Category"
    expect(page).to have_content "Category was successfully created."
  end

  scenario "should allow user to update a category" do
    visit "/categories"
    click_link category.name
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

  scenario 'should show carriers for category as a link' do
    visit category_path(category)
    expect(page).to have_content(category.name)
    find_link(carrier.name).click
    expect(page).to have_current_path(carrier_path(carrier))
  end

  scenario 'should show a empty message if category has no carriers' do
    category.carriers = []

    visit category_path(category)

    expect(page).to have_content(
      'There are no carriers of this type in ' +
      'inventory at this time. Please check back later.'
    )
  end

  scenario 'should expand the subcategories table' do
    visit(categories_path)
    expect(page).to have_content(category.name)
    expect(page).not_to have_content(category_child.name)
    find_link('+').click
    expect(page).to have_content(category_child.name)
  end
end

# frozen_string_literal: true

RSpec.feature "category" do
  let!(:category) { categories(:category_parent) }
  let!(:category_child) { categories(:category) }
  let(:user) { users(:admin_org) }

  before do
    visit subdomain_root_url
    sign_in user
  end

  it "allows user to create a category" do
    visit categories_url
    find_link("+ New").click
    fill_in "Name", with: "pineapple"
    fill_in "Description", with: "sweet"
    fill_in "Parent", with: "1"
    click_button "Create Category"

    expect(page).to have_content "Category was successfully created."
  end

  it "allows user to update a category" do
    visit categories_url
    click_link category.name
    expect(page).to have_content category.name
    find_link("Edit").click
    fill_in "Name", with: "orange"
    click_button "Update Category"
    expect(page).to have_content "Category was successfully updated."
    expect(page).to have_content "orange"
  end

  it "allows user to delete a category" do
    visit categories_url
    expect(page).to have_content category.name
    find_link("Destroy").click
    expect(page).to have_content "Category was successfully destroyed."
  end

  it 'expands the subcategories table' do
    visit(categories_url)
    expect(page).to have_content(category.name)
    expect(page).not_to have_content(category_child.name)
    find_link('+').click
    expect(page).to have_content(category_child.name)
  end
end

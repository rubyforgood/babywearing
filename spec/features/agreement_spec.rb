# frozen_string_literal: true

RSpec.feature 'create an agreement', type: :feature do
  let(:user) { users(:admin) }
  let(:agreement) { agreements(:agreement) }

  before do
    visit "/"
    sign_in user
  end

  scenario 'SHOW' do
    visit agreements_path
    click_on agreement.title

    expect(page).to have_content('Test Agreement')
    expect(page).to have_content('Content')
  end

  scenario 'EDIT when name is NOT given' do
    visit edit_agreement_path(agreement.id)

    fill_in 'Title', with: nil
    click_on 'Update Agreement'

    expect(page).to have_content("Title can't be blank")
  end

  scenario 'EDIT when all expected information is given' do
    visit edit_agreement_path(agreement.id)

    fill_in 'Title', with: 'Fake agreement'
    fill_in 'Content', with: 'Content of Fake agreement'
    click_on 'Update Agreement'

    expect(page).to have_content('Agreement was successfully updated.')
    expect(page).to have_content('Fake agreement')
    expect(page).to have_content('Content of Fake agreement')
  end

  scenario 'DESTROY when delete button is clicked' do
    visit agreements_path
    click_link 'Destroy'

    expect(page).to have_content('Agreement was successfully destroyed.')
  end

  scenario 'CREATE when title is NOT given' do
    visit agreements_path

    click_link('+ New')
    fill_in 'Title', with: nil
    fill_in 'Content', with: 'Content of Fake Agreement'
    click_on 'Create Agreement'

    expect(page).to have_content("Title can't be blank")
  end

  scenario 'CREATE when all expected information is given' do
    visit agreements_path

    click_link('+ New')
    fill_in 'Title', with: 'Fake Agreement'
    fill_in 'Content', with: 'Content of Fake Agreement'
    click_on 'Create Agreement'

    expect(page).to have_content('Agreement was successfully created.')
  end
end

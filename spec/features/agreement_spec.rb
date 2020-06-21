# frozen_string_literal: true

RSpec.feature 'create an agreement', type: :feature do
  let(:user) { users(:admin) }
  let(:agreement) { agreements(:agreement) }

  before do
    visit '/'
    sign_in user
  end

  scenario 'SHOW' do
    visit agreements_url
    click_on agreement.name

    expect(page).to have_content('Test Agreement')
  end

  scenario 'EDIT when name is NOT given' do
    visit edit_agreement_url(agreement.id)

    fill_in 'Name', with: nil
    click_on 'Update Agreement'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'EDIT when all expected information is given' do
    visit edit_agreement_url(agreement.id)

    fill_in 'Name', with: 'Fake agreement'
    click_on 'Update Agreement'

    expect(page).to have_content('Agreement was successfully updated.')
    expect(page).to have_content('Fake agreement')
  end

  scenario 'DESTROY when delete button is clicked' do
    AgreementVersion.update_all(active: false) # TODO: this can be better
    visit agreements_url
    click_link 'Destroy'

    expect(page).to have_content('Agreement was successfully destroyed.')
  end

  scenario 'CREATE when name is NOT given' do
    visit agreements_url

    click_link('+ New')
    fill_in 'Name', with: nil
    click_on 'Create Agreement'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'CREATE when all expected information is given' do
    visit agreements_url

    click_link('+ New')
    fill_in 'Name', with: 'Fake Agreement'
    click_on 'Create Agreement'

    expect(page).to have_content('Agreement was successfully created.')
  end
end

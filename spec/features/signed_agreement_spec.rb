# frozen_string_literal: true

RSpec.describe SignedAgreement do
  fixtures :users
  fixtures :agreements

  let(:user) { users(:user) }
  let(:agreement) { agreements(:agreement) }

  before do
    visit '/'
    sign_in user
  end

  scenario 'SHOW' do
    visit agreement_path(agreement.id)
    click_link 'Sign'

    expect(page).to have_content(agreement.title)
    expect(page).to have_content(agreement.content)
  end

  scenario 'CREATE' do
    visit signed_agreement_path(agreement.id)

    fill_in 'signed_agreement_signature', with: 'RFG'

    click_on 'I Agree'

    expect(page).to have_content('Agreement was successfully signed.')
  end
end

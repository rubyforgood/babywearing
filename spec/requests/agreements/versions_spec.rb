# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Agreements::Versions', type: :request do
  let(:admin) { users(:admin) }
  let(:admin2) { users(:admin2) }
  let(:agreement) { agreements(:agreement) }
  let(:version) { agreement_versions(:agreement_version) }
  let(:valid_params) do
    { title: 'hi ho hi',
      content: 'ho hi ho',
      version: '1',
      active: 'false' }
  end

  describe '#create' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { agreement_versions_url(agreement) }
      let(:params) { { agreement_version: valid_params } }
    end
    context 'with valid attributes' do
      it 'creates the version' do
        sign_in admin2

        expect { post agreement_versions_url(agreement), params: { agreement_version: valid_params } }
          .to change(AgreementVersion, :count)
        new_version = AgreementVersion.last
        expect(response).to redirect_to(agreement_version_url(agreement, new_version))
        expect(new_version.title).to eq(valid_params[:title])
        expect(new_version.last_modified_by_id).to eq(admin2.id)
      end
    end

    context 'with incomplete attributes' do
      it 'does not create the version' do
        sign_in admin

        expect { post agreement_versions_url(agreement), params: { agreement_version: valid_params.merge(title: '') } }
          .not_to change(AgreementVersion, :count)
        expect(response).to redirect_to(new_agreement_version_url(agreement))
        expect(flash[:error].first).to match(/Title can't be blank/)
      end
    end
  end

  describe '#destroy' do
    it_behaves_like 'admin authorized-only resource', :delete do
      let(:endpoint) { agreement_version_url(agreement, version) }
    end
    context 'with inactive version' do
      it 'destroys the version' do
        version.update(active: false)
        sign_in admin

        expect { delete agreement_version_url(agreement, version) }.to change(AgreementVersion, :count).by(-1)
        expect(response).to redirect_to(agreement_url(agreement))
      end
    end

    context 'with active version' do
      it 'cannot destroy the version' do
        version.active = true
        version.save
        sign_in admin

        expect { delete agreement_version_url(agreement, version) }.not_to change(AgreementVersion, :count)
        expect(response).to redirect_to(agreement_version_url(agreement, version))
      end
    end
  end

  describe '#edit' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { edit_agreement_version_url(agreement, version) }
    end
    it 'brings up the edit form' do
      sign_in admin
      get edit_agreement_version_url(agreement, version)

      expect(response).to be_successful
      expect(response.body).to match(/Editing Agreement Version/)
    end
  end

  describe '#index' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { agreement_versions_url(agreement) }
    end
    it 'brings up the index' do
      sign_in admin
      get agreement_versions_url(agreement)

      expect(response).to be_successful
      expect(response.body).to match(/Agreement Versions - #{agreement.name}/)
    end
  end

  describe '#new' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_agreement_version_url(agreement) }
    end
    it 'loads the form' do
      sign_in admin
      get new_agreement_version_url(agreement)

      expect(response).to be_successful
      expect(response.body).to match(/New Agreement Version/)
    end
  end

  describe '#show' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { agreement_version_url(agreement, version) }
    end
    it 'shows the version' do
      sign_in admin
      get agreement_version_url(agreement, version)

      expect(response).to be_successful
      expect(response.body).to match(/#{version.title}/)
    end
  end

  describe '#update' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:endpoint) { agreement_version_url(agreement, version) }
      let(:params) { { agreement_version: valid_params } }
    end
    context 'with invalid attributes' do
      it 'does not update the version and returns to the form' do
        sign_in admin
        original_content = version.content
        put agreement_version_url(agreement, version),
            params: { agreement_version: valid_params.merge({ content: '' }) }

        expect(flash[:error].first).to match(/Content can't be blank/)
        expect(version.reload.content).to eq(original_content)
        expect(response).to redirect_to(edit_agreement_version_url(agreement, version))
      end
    end

    context 'with valid attributes' do
      it 'updates the version' do
        sign_in admin2

        put agreement_version_url(agreement, version),
            params: { agreement_version: valid_params }

        expect(response).to redirect_to(agreement_version_url(agreement, version))
        expect(version.reload.title).to eq(valid_params[:title])
        expect(version.last_modified_by).to eq(admin2)
      end
    end
  end
end

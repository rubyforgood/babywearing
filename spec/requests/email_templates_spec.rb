# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EmailTemplates', type: :request do
  let(:email_template) { email_templates(:checkout) }
  let(:valid_attr) do
    {
      type: 'CheckoutEmailTemplate',
      name: 'Checkout acknowledgement',
      subject: 'Midatlantic Carrier Loan',
      body: 'Your carrier is almost due',
      when_sent: 'before',
      when_days: 7,
      active: true
    }
  end
  let(:invalid_attr) { { name: '' } }

  describe 'GET /email_templates' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { email_templates_url }
    end
    it 'successfully renders the index' do
      sign_in users(:admin)
      get email_templates_url

      expect(response).to be_successful
      expect(response.body).to match(/Checkout/)
    end
  end

  describe 'GET /email_templates/:id/edit' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { edit_email_template_url(email_template) }
    end
    it 'successfully loads the form' do
      sign_in users(:admin)
      get edit_email_template_url(email_template)

      expect(response).to be_successful
      expect(response.body).to match(/Edit Checkout Email Template/)
    end
  end

  describe 'GET /email_templates/new' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_email_template_url }
    end
    it 'successfully loads the form' do
      sign_in users(:admin)
      get new_email_template_url

      expect(response).to be_successful
      expect(response.body).to match(/New Email Template/)
    end
  end

  describe 'POST /email_templates' do
    let(:params) { { email_template: valid_attr } }

    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { email_templates_url }
    end

    context 'with valid attributes' do
      it 'creates an email_template' do
        sign_in users(:admin)
        expect do
          post email_templates_url, params: { email_template: valid_attr }
        end.to change(CheckoutEmailTemplate, :count)

        expect(CheckoutEmailTemplate.last).to be_active
        expect(response).to redirect_to(email_templates_url)
        expect(flash[:notice]).to eq('Email template was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't create an email template" do
        sign_in users(:admin)
        expect do
          post email_templates_url, params: { email_template: invalid_attr }
        end.not_to change(ReminderEmailTemplate, :count)

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /email_template/:id' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { email_template_url(email_template) }
    end
    it 'gets the show page' do
      sign_in users(:admin)
      get email_template_url(email_template)

      expect(response).to be_successful
      expect(response.body).to match(/#{email_template.name}/)
    end
  end

  describe 'PUT /email_template/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:endpoint) { email_template_url(email_template) }
      let(:params) { { email_template: valid_attr } }
    end

    context 'with valid attributes' do
      it 'updates the email template' do
        sign_in users(:admin)
        send :put, email_template_url(email_template), params: { email_template: valid_attr }

        expect(flash[:notice]).to eq('Email template was successfully updated.')
        expect(email_template.reload.name).to eq(valid_attr[:name])
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the email template" do
        sign_in users(:admin)
        name = email_template.name
        send :put, email_template_url(email_template), params: { email_template: invalid_attr }

        expect(response.body).to match(/prohibited this/)
        expect(email_template.reload.name).to eq(name)
      end
    end
  end

  describe 'DELETE /email_template/:id' do
    it_behaves_like 'admin authorized-only resource', :delete do
      let(:endpoint) { email_template_url(email_template) }
    end
    it 'destroys the email template' do
      sign_in users(:admin)
      send :delete, email_template_url(email_template)

      expect(response).to redirect_to(email_templates_url)
      expect(flash[:alert]).to eq('Email template was successfully destroyed')
      expect(email_template).not_to exist_in_database
    end
  end
end

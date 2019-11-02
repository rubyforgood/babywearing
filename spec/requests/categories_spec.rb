# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:category) { categories(:category_parent) }

  describe 'GET /categories' do
    it 'has http status 200' do
      sign_in users(:member)
      send :get, categories_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/category parent/)
    end
  end

  describe "GET /categories/new" do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { new_category_path }
    end
  end

  describe 'POST /categories' do
    it_behaves_like 'admin authorized-only resource', :post do
      let(:endpoint) { categories_path }
      let(:params) { { category: { name: 'Test', description: 'Test content' } } }
    end

    let(:valid_attr) { { name: 'Test', description: 'Test content' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'creates a category' do
        sign_in users(:admin)
        send :post, categories_path, params: { category: valid_attr }

        expect(response).to redirect_to(category_path(assigns(:category)))
        expect(flash[:notice]).to eq('Category was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it "doen't create a category" do
        sign_in users(:admin)
        send :post, categories_path, params: { category: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'GET /categories/:id' do
    it 'has have_http_status 200' do
      sign_in users(:member)
      send :get, categories_path(category)

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/category parent/)
    end
  end

  describe 'PUT /category/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:category) { categories(:category_parent) }
      let(:endpoint) { category_path(category) }
      let(:params) { { category: { name: 'Test', description: 'Test' } } }
    end

    let(:valid_attr) { { name: 'New agreement', description: 'New content' } }
    let(:invalid_attr) { { name: '' } }

    context 'with valid attributes' do
      it 'updates the category' do
        sign_in users(:admin)
        send :put, category_path(category), params: { category: valid_attr }

        expect(flash[:notice]).to eq('Category was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the category" do
        sign_in users(:admin)
        send :put, category_path(category), params: { category: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end

  describe 'DELETE /category/:id' do
    let(:category) { Category.create(name: 'Test', description: 'Test') }

    it_behaves_like "admin authorized-only resource", :delete do
      let(:category) { Category.create(name: 'Test', description: 'Test') }
      let(:endpoint) { category_path(category) }
    end

    it 'destroys the category' do
      sign_in users(:admin)
      send :delete, category_path(category)

      expect(response).to have_http_status(:found)
      expect(flash[:alert]).to eq('Category was successfully destroyed.')
    end
  end
end

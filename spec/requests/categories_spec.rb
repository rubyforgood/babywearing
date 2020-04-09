# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:category) { categories(:category_parent) }

  within_subdomain("admin") do
    describe 'GET /categories' do
      it 'has http status 200' do
        sign_in users(:admin_org)
        get categories_url

        expect(response).to be_successful
        expect(response.body).to match(/category parent/)
      end
    end

    describe 'POST /categories' do
      let(:valid_attr) { { name: 'Test', description: 'Test content' } }
      let(:invalid_attr) { { name: '' } }

      context 'with valid attributes' do
        it 'creates a category' do
          sign_in users(:admin_org)
          post categories_url, params: { category: valid_attr }

          expect(response).to redirect_to(category_url(assigns(:category)))
          expect(flash[:notice]).to eq('Category was successfully created.')
        end
      end

      context 'with invalid attributes' do
        it "doen't create a category" do
          sign_in users(:admin_org)
          send :post, categories_url, params: { category: invalid_attr }

          expect(response.body).to match(/prohibited this/)
        end
      end
    end

    describe 'GET /categories/:id' do
      it 'has have_http_status 200' do
        sign_in users(:admin_org)
        get categories_url(category)

        expect(response).to be_successful
        expect(response.body).to match(/category parent/)
      end
    end

    describe 'PUT /category/:id' do
      let(:valid_attr) { { name: 'New agreement', description: 'New content' } }
      let(:invalid_attr) { { name: '' } }

      context 'with valid attributes' do
        it 'updates the category' do
          sign_in users(:admin_org)
          send :put, category_url(category), params: { category: valid_attr }

          expect(flash[:notice]).to eq('Category was successfully updated.')
        end
      end

      context 'with invalid attributes' do
        it "doesn't update the category" do
          sign_in users(:admin_org)
          send :put, category_url(category), params: { category: invalid_attr }

          expect(response.body).to match(/prohibited this/)
        end
      end
    end

    describe 'DELETE /category/:id' do
      let(:category) { Category.create(name: 'Test', description: 'Test') }

      it 'destroys the category' do
        sign_in users(:admin_org)
        send :delete, category_url(category)

        expect(response).to have_http_status(:found)
        expect(flash[:alert]).to eq('Category was successfully destroyed.')
      end
    end
  end

  within_subdomain("midatlantic") do
    describe 'GET /categories' do
      it 'has a routing error' do
        sign_in users(:member)
        expect do
          get "http://midatlantic.example.com/categories"
        end.to raise_error(ActionController::RoutingError)
      end
    end
  end
end

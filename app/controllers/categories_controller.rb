# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  def index
    @categories = Category.where(parent_id: nil).includes(:subcategories).order(:name)
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = authorize Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = authorize Category.new(category_params)

    if @category.save
      redirect_to category_url(@category, subdomain: current_tenant.subdomain),
                  notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    authorize @category

    if @category.update(category_params)
      redirect_to category_url(@category, subdomain: current_tenant.subdomain),
                  notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    authorize @category

    return unless @category.destroy

    redirect_to categories_url(subdomain: current_tenant.subdomain), alert: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :parent_id)
  end
end

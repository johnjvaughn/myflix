class CategoriesController < ApplicationController
  layout "application"

  def show
    @category = Category.find(params[:id])
  end
end

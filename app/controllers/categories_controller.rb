class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def hierarchy
    @categories = params[:roots_only] == 'false' ? Category.all : Category.roots
    render :hierarchy
  end
end

class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render :hierarchy
  end

  def hierarchy
    @categories = params[:roots_only] == 'false' ? Category.all : Category.roots
  end
end

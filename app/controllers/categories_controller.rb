class CategoriesController < ApplicationController

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    #運用關聯設定
    @restaurants = @category.restaurants.page(params[:page]).per(9)
  end

end

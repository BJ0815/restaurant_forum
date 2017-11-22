class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_restaurant, only: [:show, :edit, :update]
  
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "Restaurant is successfully created"
      redirect_to admin_restaurants_path
    else
      flash[:alert] = "Restaurant is failed created"
      render :new
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant is successfully updated"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash[:alert] = "Restaurant is failed updated"
      render :edit
    end
  end



  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :opening_hours, :description)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end




end

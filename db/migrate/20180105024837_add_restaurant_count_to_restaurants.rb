class AddRestaurantCountToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :restaurant_count, :integer
  end
end

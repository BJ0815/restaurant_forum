class AddRestaurantCountToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :favorites_count, :integer, :default => 0 #預設值為0

    Restaurant.pluck(:id).each do |i| #從Restaurant中取得由id組成的array

      Restaurant.reset_counters(i, :favorites)  #把所有counter_cache重算一次以免有-1出現

    end
  end
end

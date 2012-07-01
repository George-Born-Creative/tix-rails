class AddDefaultPriceToAreaSeat < ActiveRecord::Migration
  def change
    add_column :area_seats, :default_price, :decimal
    
  end
end

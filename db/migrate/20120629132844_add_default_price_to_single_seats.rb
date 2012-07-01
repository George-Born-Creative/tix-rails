class AddDefaultPriceToSingleSeats < ActiveRecord::Migration
  def change
    add_column :single_seats, :default_price, :decimal
  end
end

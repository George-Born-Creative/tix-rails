class AddForeignKeysToSeats < ActiveRecord::Migration
  def change
    add_column :area_seats, :seating_chart_id, :integer
    
  end
end

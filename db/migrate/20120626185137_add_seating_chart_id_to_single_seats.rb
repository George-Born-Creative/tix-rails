class AddSeatingChartIdToSingleSeats < ActiveRecord::Migration
  def change
    add_column :single_seats, :seating_chart_id, :integer
  end
end

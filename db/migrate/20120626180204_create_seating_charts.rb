class CreateSeatingCharts < ActiveRecord::Migration
  def change
    create_table :seating_charts do |t|
      t.string :name
      t.string :background_image_url

      t.timestamps
    end
  end
end

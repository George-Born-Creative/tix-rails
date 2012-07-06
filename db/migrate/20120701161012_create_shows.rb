class CreateS < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.number :seating_chart_id

      t.timestamps
    end
  end
end

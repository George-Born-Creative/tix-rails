class CreateWidgetPlacements < ActiveRecord::Migration
  def change
    create_table :widget_placements do |t|
      t.integer :sidebar_id
      t.integer :widget_id
      t.integer :account_id
      t.integer :index

      t.timestamps
    end
  end
end

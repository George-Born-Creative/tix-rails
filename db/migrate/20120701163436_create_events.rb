class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :headline
      t.text :supporting_act
      t.string :image_uri
      t.string :image_thumb_uri
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :seating_chart_id

      t.timestamps
    end
  end
end

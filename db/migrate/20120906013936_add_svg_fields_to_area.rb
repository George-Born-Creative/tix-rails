class AddSvgFieldsToArea < ActiveRecord::Migration
  def change
    add_column :areas, :cx, :decimal
    add_column :areas, :cy, :decimal
    add_column :areas, :r, :decimal
    add_column :areas, :width, :decimal
    add_column :areas, :height, :decimal
    add_column :areas, :transform, :string
    add_column :areas, :points, :string
  end
end

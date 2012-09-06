class AddWidthHeightToCharts < ActiveRecord::Migration
  def change
    add_column :charts, :width, :decimal
    add_column :charts, :height, :decimal
  end
end

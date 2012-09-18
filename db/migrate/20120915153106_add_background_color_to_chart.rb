class AddBackgroundColorToChart < ActiveRecord::Migration
  def change
    add_column :charts, :background_color, :string
  end
end

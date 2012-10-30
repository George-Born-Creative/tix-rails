class AddBaseToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :base, :decimal
  end
end

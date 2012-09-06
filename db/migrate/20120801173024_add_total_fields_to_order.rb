class AddTotalFieldsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total, :decimal, :precision => 8, :scale => 2, :null => false, :default => 0.00
    add_column :orders, :tax, :decimal, :precision => 8, :scale => 2, :null => false, :default => 0.00
    add_column :orders, :service_charge, :decimal, :precision => 8, :scale => 2, :null => false, :default => 0.00
  end
end

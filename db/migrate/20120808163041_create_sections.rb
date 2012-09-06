class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :label
      t.decimal :default_base_price, :precision => 8, :scale => 2, :null => false, :default => 0.00
      t.decimal :default_service_charge, :precision => 8, :scale => 2, :null => false, :default => 0.00
      
      t.references :chart
      
      t.timestamps
    end
  end
end

class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :label
      
      t.decimal :base, :null => false, :default => 0.0, :precision =>  8, :scale => 2
      t.decimal :service, :null => false, :default => 0.0, :precision =>  8, :scale => 2
      t.decimal :tax, :null => false, :default => 0.0, :precision =>  8, :scale => 2
      
      t.references :account
      t.references :section
      
      t.timestamps
    end
  end
end

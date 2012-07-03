class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :label
      t.string :polypath
      t.decimal :x
      t.decimal :y
      t.integer :stack_order, :default => 0 
      t.references :chart
      
      t.string :type
            
    end
  end
end

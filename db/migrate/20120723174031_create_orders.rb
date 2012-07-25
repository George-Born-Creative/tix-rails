class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
     t.string 'status', :null => false, :default => 'pending' # pending paid canceled
     t.timestamps
    end
    
    add_index :orders, :status
    
  end
  
end

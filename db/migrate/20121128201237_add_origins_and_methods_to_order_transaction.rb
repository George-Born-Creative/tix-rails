class AddOriginsAndMethodsToOrderTransaction < ActiveRecord::Migration
  def change
    add_column :order_transactions, :method, :string
    add_column :order_transactions, :origin, :string
    
    add_index :order_transactions, :method
    add_index :order_transactions, :origin
  end
end

class AddOriginsAndMethodsToOrderTransaction < ActiveRecord::Migration
  def change
    add_column :order_transactions, :meth, :string
    add_column :order_transactions, :origin, :string
    
    add_index :order_transactions, :meth
    add_index :order_transactions, :origin
  end
end

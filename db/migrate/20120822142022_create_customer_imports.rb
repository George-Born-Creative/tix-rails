class CreateCustomerImports < ActiveRecord::Migration
  def change
    create_table :customer_imports do |t|
      t.references :account
      t.string :state
      t.timestamps
    end
    
    add_attachment :customer_imports, :data
  
  end
end

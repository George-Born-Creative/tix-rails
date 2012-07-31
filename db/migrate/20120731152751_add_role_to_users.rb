class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :default => 'customer'
    add_index :users, :role
    
  end
  
end

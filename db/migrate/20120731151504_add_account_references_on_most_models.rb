class AddAccountReferencesOnMostModels < ActiveRecord::Migration
  def change
    add_column :charts, :account_id, :integer, :null => false, :default => 0 
    add_column :events, :account_id, :integer, :null => false, :default => 0
    add_column :artists, :account_id, :integer, :null => false, :default => 0
    add_column :tickets, :account_id, :integer, :null => false, :default => 0
    add_column :users, :account_id, :integer, :null => false, :default => 0
    add_column :orders, :account_id, :integer, :null => false, :default => 0
  end
end

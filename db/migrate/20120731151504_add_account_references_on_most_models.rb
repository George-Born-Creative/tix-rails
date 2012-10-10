class AddAccountReferencesOnMostModels < ActiveRecord::Migration
  def change
    add_column :charts, :account_id, :integer#, :null => false
    add_column :events, :account_id, :integer#, :null => false
    add_column :artists, :account_id, :integer#, :null => false
    add_column :tickets, :account_id, :integer#, :null => false
    add_column :users, :account_id, :integer#, :null => false
    add_column :orders, :account_id, :integer#, :null => false
  end
end

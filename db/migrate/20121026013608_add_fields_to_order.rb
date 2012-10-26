class AddFieldsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_type, :string
    add_column :orders, :card_expiration_month, :string
    add_column :orders, :card_expiration_year, :string
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :purchased_at, :datetime
    
  end
end

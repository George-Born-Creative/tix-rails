class AddIndexesToAccountIds < ActiveRecord::Migration
  def change
    add_index :users, :account_id
    add_index :artists, :account_id
    add_index :events, :account_id
    add_index :tickets, :account_id
    add_index :orders, :account_id
    add_index :pages, :account_id
    add_index :charts, :account_id
    add_index :sidebars, :account_id
    add_index :images, :account_id
    add_index :widgets, :account_id
    add_index :ticket_templates, :account_id
    add_index :customer_imports, :account_id
    add_index :carousels, :account_id
    add_index :themes, :account_id
    add_index :gateways, :account_id
  end
end

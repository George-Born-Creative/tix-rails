class AddFieldsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :base_price, :decimal
    add_column :tickets, :service_charge, :decimal
  end
end

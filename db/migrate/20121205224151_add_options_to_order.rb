class AddOptionsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :deliver_tickets, :boolean
    add_column :orders, :checkin_tickets, :boolean
    add_column :orders, :service_charge_override, :decimal
    add_column :orders, :agent_checkout, :boolean
    add_column :orders, :tickets_delivered_at, :datetime
  end
end

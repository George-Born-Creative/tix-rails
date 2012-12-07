class AddServiceChargeOverrideToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :service_charge_override, :decimal
  end
end

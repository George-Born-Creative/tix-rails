class AddGatewayModeToOrderTransaction < ActiveRecord::Migration
  def change
    add_column :order_transactions, :gateway_mode, :string
  end
end

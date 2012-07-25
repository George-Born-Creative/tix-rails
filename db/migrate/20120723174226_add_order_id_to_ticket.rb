class AddOrderIdToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :order_id, :integer
  end
end

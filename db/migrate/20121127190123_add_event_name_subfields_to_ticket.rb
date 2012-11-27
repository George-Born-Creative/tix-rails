class AddEventNameSubfieldsToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :event_name_1, :string
    add_column :tickets, :event_name_2, :string
  end
end

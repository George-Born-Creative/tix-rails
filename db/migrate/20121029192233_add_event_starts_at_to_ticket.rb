class AddEventStartsAtToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :event_starts_at, :datetime
  end
end

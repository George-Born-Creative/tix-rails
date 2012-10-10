class RemoveCheckedInFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :checked_in
  end
end

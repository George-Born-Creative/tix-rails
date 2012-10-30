class DropStateFromTickets < ActiveRecord::Migration
  def up
    remove_column :tickets, :state
  end

  def down
  end
end

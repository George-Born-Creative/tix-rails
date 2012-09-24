class AddCheckedInToTickets < ActiveRecord::Migration
  def change
     add_column :tickets, :checked_in, :boolean, :default => false, :null => false
     add_column :tickets, :checked_in_at, :Datetime
     add_column :tickets, :status, :string    
  end
end

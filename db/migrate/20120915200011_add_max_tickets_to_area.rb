class AddMaxTicketsToArea < ActiveRecord::Migration
  def change
    add_column :areas, :max_tickets, :integer, :null => false, :default => 1    
  end
end

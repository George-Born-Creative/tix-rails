class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      
      t.decimal :price
      t.string :state, :null => false, :default => 'open'
      t.references :event
      t.references :area
      
      t.timestamps
    end
    
    add_index :tickets, :state
  end
end

# Ticket States: open closed sold expired

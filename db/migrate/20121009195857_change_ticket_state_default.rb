class ChangeTicketStateDefault < ActiveRecord::Migration
  def up
    change_column_default(:tickets, :state, nil)
    
  end
end

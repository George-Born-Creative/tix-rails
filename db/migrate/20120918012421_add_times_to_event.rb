class AddTimesToEvent < ActiveRecord::Migration
  def change
    
    
    add_column :events, :announce_at, :datetime
    add_column :events, :on_sale_at, :datetime
    add_column :events, :off_sale_at, :datetime
    add_column :events, :remove_at, :datetime
    
  end
end

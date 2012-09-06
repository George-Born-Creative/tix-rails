class AddSeatableToSection < ActiveRecord::Migration
  def change
    add_column :sections, :seatable, :boolean, :null => false, :default => false
  end
end

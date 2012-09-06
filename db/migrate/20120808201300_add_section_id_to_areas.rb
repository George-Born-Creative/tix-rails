class AddSectionIdToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :section_id, :integer
    add_index :areas, :section_id, :null => false
  end
end

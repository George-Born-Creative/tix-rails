class AddFieldsToEvents < ActiveRecord::Migration
  def up
    add_column :events, :info, :text
    add_column :events, :set_times, :text
    add_column :events, :price_freeform, :string
        
    remove_column :events, :image_uri
    remove_column :events, :image_thumb_uri
  end
  
  def down
    remove_column :events, :info
    remove_column :events, :set_times
    remove_column :events, :price_freeform
        
    add_column :events, :image_uri, :string
    add_column :events, :image_thumb_uri, :string
  end
end
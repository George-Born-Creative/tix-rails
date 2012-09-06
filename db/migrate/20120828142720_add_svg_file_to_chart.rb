class AddSvgFileToChart < ActiveRecord::Migration
  def change
    
    add_column :charts, :svg_file_file_name, :string
    add_column :charts, :svg_file_content_type, :string
    add_column :charts, :svg_file_file_size, :integer
    add_column :charts, :svg_file_updated_at, :datetime
    
    add_column :charts, :thumbnail_file_name, :string
    add_column :charts, :thumbnail_content_type, :string
    add_column :charts, :thumbnail_file_size, :integer
    add_column :charts, :thumbnail_updated_at, :datetime
   
  end
end

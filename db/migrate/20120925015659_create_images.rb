class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.string :caption
      t.string :type
      t.timestamps
    end
    
    add_column :images, :file_file_name, :string
    add_column :images, :file_content_type, :string
    add_column :images, :file_file_size, :integer
    add_column :images, :file_updated_at, :datetime
  end
end

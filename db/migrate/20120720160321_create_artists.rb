class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.text :body
      t.text :description
      t.string :url
      t.string :myspace_url
      t.string :facebook_url
      t.string :audio_sample_url
      t.string :video_url
      t.string :twitter
      t.string :youtube1
      t.string :youtube2

      t.timestamps
    end
    
    add_column :artists, :photo_file_name, :string
    add_column :artists, :photo_content_type, :string
    add_column :artists, :photo_file_size, :integer
    add_column :artists, :photo_updated_at, :datetime 
    
  end
end

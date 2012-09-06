class AddOldImageIdToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :id_old_image, :integer
    add_column :artists, :audio_sample_title, :string
  end
end

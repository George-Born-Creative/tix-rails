class AddArtistIdOldSecondaryToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :artist_id_old_secondary, :integer
  end
end

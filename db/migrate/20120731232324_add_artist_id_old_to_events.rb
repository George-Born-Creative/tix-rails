class AddArtistIdOldToEvents < ActiveRecord::Migration
  def change
    add_column :events, :artist_id_old, :integer
  end
end

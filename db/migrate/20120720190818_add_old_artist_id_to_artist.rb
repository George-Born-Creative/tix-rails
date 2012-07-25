class AddOldArtistIdToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :id_old, :integer
  end
end

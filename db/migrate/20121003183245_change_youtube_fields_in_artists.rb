class ChangeYoutubeFieldsInArtists < ActiveRecord::Migration
  def up
    change_column :artists, :youtube1, :text
    change_column :artists, :youtube2, :text
  end

  def down
    change_column :artists, :youtube1, :string
    change_column :artists, :youtube2, :string
  end
end

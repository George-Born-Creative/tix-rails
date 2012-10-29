class AddEventArtistsToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :event_artists, :string
  end
end

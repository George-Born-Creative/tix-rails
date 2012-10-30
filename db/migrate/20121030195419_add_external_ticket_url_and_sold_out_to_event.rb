class AddExternalTicketUrlAndSoldOutToEvent < ActiveRecord::Migration
  def change
    add_column :events, :external_ticket_url, :string
    add_column :events, :sold_out, :boolean
  end
end

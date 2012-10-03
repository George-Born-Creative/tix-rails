class AddBuytixUrlOldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :buytix_url_old, :string
  end
end

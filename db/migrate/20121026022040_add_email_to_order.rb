class AddEmailToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :event_name, :string
    add_column :orders, :event_artists, :string
    add_column :orders, :section_label, :string
    add_column :orders, :area_label, :string
    add_column :orders, :email, :string
  end
end

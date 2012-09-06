class AddFieldsToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :area_label, :string
    add_column :tickets, :section_label, :string
  end
end

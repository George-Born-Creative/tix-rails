class AddCatToEvent < ActiveRecord::Migration
  def change
    add_column :events, :cat, :string
  end
end

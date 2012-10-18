class AddTextToArea < ActiveRecord::Migration
  def change
    add_column :areas, :text, :string
  end
end

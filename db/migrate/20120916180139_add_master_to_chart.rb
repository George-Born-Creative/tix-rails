class AddMasterToChart < ActiveRecord::Migration
  def change
    add_column :charts, :master, :boolean, :default => false
  end
end

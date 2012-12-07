class RemoveDefaultOrderStateDbDefault < ActiveRecord::Migration
  def up
    change_column_default(:orders, :state, nil)
    remove_column :orders, :status
  end

  def down
  end
end

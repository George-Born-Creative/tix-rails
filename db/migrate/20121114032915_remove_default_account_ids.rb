class RemoveDefaultAccountIds < ActiveRecord::Migration
  def up
    change_column_default(:tickets, :account_id, nil)
    change_column_default(:events, :account_id, nil)
    change_column_default(:artists, :account_id, nil)
    change_column_default(:orders, :account_id, nil)
    change_column_default(:users, :account_id, nil)
  end

  def down
  end
end

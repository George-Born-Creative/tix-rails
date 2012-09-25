class AddAccountIdToSidebarImage < ActiveRecord::Migration
  def change
    add_column :images, :account_id, :integer
  end
end

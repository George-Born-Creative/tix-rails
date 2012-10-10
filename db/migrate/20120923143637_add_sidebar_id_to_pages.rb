class AddSidebarIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sidebar_id, :integer
  end
end

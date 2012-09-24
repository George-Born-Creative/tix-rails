class AddSidebarIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sidebar_id, :number
  end
end

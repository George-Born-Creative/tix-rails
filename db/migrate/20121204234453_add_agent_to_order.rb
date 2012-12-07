class AddAgentToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :agent_id, :integer
  end
end

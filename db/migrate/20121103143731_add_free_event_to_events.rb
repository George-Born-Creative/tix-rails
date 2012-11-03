class AddFreeEventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :free_event, :boolean
  end
end

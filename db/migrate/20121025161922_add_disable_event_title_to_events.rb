class AddDisableEventTitleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :disable_event_title, :boolean, :default => false
  end
end

class AddHideButtonsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hide_buttons, :boolean
  end
end

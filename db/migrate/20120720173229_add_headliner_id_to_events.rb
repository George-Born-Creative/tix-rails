class AddHeadlinerIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :headliner_id, :integer
    add_column :events, :secondary_headliner_id, :integer
  end
end

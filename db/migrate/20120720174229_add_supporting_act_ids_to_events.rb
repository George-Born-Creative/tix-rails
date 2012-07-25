class AddSupportingActIdsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :supporting_act_1, :string
    add_column :events, :supporting_act_2, :string
    add_column :events, :supporting_act_3, :string
  end
end

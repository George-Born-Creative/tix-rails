class AddLabelToChart < ActiveRecord::Migration
  def change
    add_column :charts, :label, :string
  end
end

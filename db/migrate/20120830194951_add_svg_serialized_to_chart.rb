class AddSvgSerializedToChart < ActiveRecord::Migration
  def change
    add_column :charts, :svg_file_serialized, :text
  end
end

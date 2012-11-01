class RemoveUnassociatedWidgetPlacements < ActiveRecord::Migration
  def up
    WidgetPlacement.all.each { |wp| wp.destroy if wp.widget.nil? }
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

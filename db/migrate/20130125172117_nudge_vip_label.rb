class NudgeVipLabel < ActiveRecord::Migration
  def up
    nudge_vip_labels
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
  
private
  def nudge_vip_labels
     (vip_areas = Area.where('text = ?', 'VIP')).each do |area|
       area.x = area.x + 3
       area.save
     end
  end
end

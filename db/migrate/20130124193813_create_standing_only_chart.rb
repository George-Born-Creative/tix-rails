class CreateStandingOnlyChart < ActiveRecord::Migration
  def up
    label = "JAMMIN JAVA GENERAL ADM ONLY"
    old_chart = Chart.find(69) # find_by_label(label)
    old_chart.update_attribute(:label, "#{label} - SEATED")
    
    new_chart = old_chart.copy
    
    new_chart.master = true
    new_chart.label = "#{label} - STANDING"
    
    new_chart.save
    
    foreground = new_chart.sections.find_by_label('Foreground')    
    
    line_2 = foreground.areas.find_by_text('Row Seating')
    line_3 = foreground.areas.find_by_text('(Some Standing)')
    
    line_2.update_attributes({:text => 'Standing', :x => line_2.x + 10 })
    line_3.update_attribute(:text, '(Some Seating)')
    
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

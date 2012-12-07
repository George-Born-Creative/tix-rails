class ChartFixes < ActiveRecord::Migration
  def up
    # Delete a stray box from one of the charts
    Area.where( :x => 8.333, :y => 444.435).delete_all
    
    
    # FIX LABELS ON STANDING ROOM ONLY
    Chart.where('label like ?', '%JAMMIN JAVA GENERAL ADM ONLY%').each do |chart|

      section = chart.sections.find_by_label('Foreground')

      section.areas.where(:type => 'text').delete_all 

      section.areas.create(x: 204.8843, y: 333.6519 - 80, :type => 'text', :text => 'General Admission')
      section.areas.create(x: 229.0433, y: 348.4683 - 80, :type => 'text', :text => 'Row Seating')
      section.areas.create(x: 245.11 - 25, y: 363.0757 - 80, :type => 'text', :text => '(Some Standing)')

      chart.save

    end
    
    # Chart.find(127).sections.where(:label=>'GA').first.update_attribute(:color, '#cfc67a')
    #
    
  end

  def down
  end
end

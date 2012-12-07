class RelabelCharts < ActiveRecord::Migration
  def up
    
    Area.all.each do |a|
      unless a.label.nil?
        label = a.label
        regexp = /^([A-Z])([0-9])$/
        match = regexp.match(label)
        if match && match.length ==3
          new_label = "#{match[1]}#{conv(match[2].to_i)}"
          a.update_attribute(:label, new_label)
        end
      end
    end

  end


  def conv(n)
    return {1 => 1, 
     2 => 3,
     3 => 5, 
     4 => 7, 
     5 => 8,
     6 => 6,
     7 => 4,
     8 => 2}[n]
  end
  
  def down
  end
  
end

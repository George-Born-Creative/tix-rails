class AddTableLabels < ActiveRecord::Migration
  def up
    
    standing_charts = Chart.where('label LIKE ?', '%JAMMIN JAVA STANDING')
    seated_charts = Chart.where('label LIKE ?', '%JAMMIN JAVA SEATED')
    
    ActiveRecord::Base.transaction do
      standing_charts.each do |chart|
        foreground = chart.sections.find_by_label('Foreground')
        inject_lower_table_labels(foreground)
      end
    end
    
    ActiveRecord::Base.transaction do
      seated_charts.each do |chart|
        foreground = chart.sections.find_by_label('Foreground')
        inject_upper_table_labels(foreground)
        inject_lower_table_labels(foreground)
      end
    end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
  
private
  
  def inject_upper_table_labels(foreground)
    labels = [    
      { text: 'A', x: 155, y: 150, type: "text" },
      { text: 'B', x: 217, y: 150, type: "text" },
      { text: 'C', x: 280, y: 150, type: "text" },
      { text: 'D', x: 340, y: 150, type: "text" },
    
      { text: 'E', x: 155, y: 228, type: "text" },
      { text: 'F', x: 217, y: 228, type: "text" },
      { text: 'G', x: 280, y: 228, type: "text" },
      { text: 'H', x: 340, y: 228, type: "text" }
    ]
    create_areas(foreground, labels)
    
  end
  
  def inject_lower_table_labels(foreground)
    
    labels = [ 
      { text: 'J', x: 58, y: 320, type: "text" },
      { text: 'K', x: 112, y: 345, type: "text" },
      { text: 'L', x: 58, y: 395, type: "text" },
      { text: 'M', x: 112, y: 427, type: "text" }
    ]
    
    create_areas(foreground, labels)
    
  end
  
  def create_areas(foreground, labels)
    labels.each do |area|
      foreground.areas.create area
    end
  end
  
end

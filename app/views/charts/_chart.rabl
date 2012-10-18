object @chart
attributes :id, :name, :background_color
  
child (:sections) do |chart|
  attributes :id, :label, :seatable, :color

  child :presale_price => :presale_price do
    attributes :id, :base, :service, :tax, :total
  end
  
  child :dayof_price => :dayof_price do
    attributes :id, :base, :service, :tax, :total
  end
  
  child(:areas) do 
    attributes :id, :type, :x, :y, :polypath, :label, :stack_order,
    :cx, :cy, :r, :width, :height, :points, :transform,
    :max_tickets, :label, :inventory, :text
    
    node :tickets_reserved_count do |area|
      area.tickets.with_state(:reserved).count
    end
    
    node :tickets_purchased_count do |area|
      area.tickets.with_state(:purchased).count
    end
    
    node :tickets_checked_in_count do |area|
      area.tickets.with_state(:checked_in).count
    end
    
  end
end



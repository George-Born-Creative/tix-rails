object @order
attributes :id, :created_at, :expires_at, :service_charge, :state, :tax, :total

child( :tickets) do
  attributes :id, :area_id, :event_id, :state, :label, :base_price, :service_charge
  
  node :area_label do |ticket|
    ticket.area.label
  end
  
  node :section_label do |ticket|
    ticket.section.label
  end
  
  node :event_name do |ticket|
    ticket.event.name
  end
  
  
end

require 'cgi'

object @event
attributes :id,
           :body,
           :title, 
           :headline, 
           :supporting_act,
           :image_uri, 
           :image_thumb_uri,
           :starts_at, 
           :ends_at,
           :info,
           :set_times,
           :price_freeform
          
node :set_times do |event|
  event.set_times.gsub(/\n/, '<br/>')
end

node :image_uri do |event|
   ( event.headliner.photo :medium).gsub(/\+/, '%2B')
end

node :image_thumb_uri do |event|
  ( event.headliner.photo :thumb).gsub(/\+/, '%2B')
end

child( :tickets) { attributes :id, :area_id, :event_id, :event_title, :status, :label, :service_charge, :area_label, :price, :area_type }
child( :chart) do
  attributes :id, :background_image_url
  child( :areas) { attributes :id, :x, :y, :type, :polypath, :label, :label_section }  
end
object @event
attributes :id, :title, :headline, :supporting_act,  :image_uri, :image_thumb_uri, :starts_at, :ends_at
child( :tickets) { attributes :id, :area_id, :event_id }
child( :chart) do
  attributes :id, :background_image_url
  child( :areas) { attributes :id, :x, :y, :type, :polypath, :label, :default_price }  
end
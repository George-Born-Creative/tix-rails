collection @events
attributes :id, :title, :headline, :supporting_act, :image_thumb_uri, :starts_at, :starts_at_formatted, :ends_at

node :image_uri do |event|
   (event.headliner.photo :medium).gsub(/\+/, '%2B')
end

node :image_thumb_uri do |event|
  ( event.headliner.photo :thumb).gsub(/\+/, '%2B')
end
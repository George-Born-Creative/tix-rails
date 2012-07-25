collection @artists
attributes :id, :name

node :photo_thumb do |a|
  a.photo.url(:thumb).gsub(/\+/, '%2B')
end
  

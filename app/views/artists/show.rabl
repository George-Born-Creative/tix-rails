object @artist
  attributes :name,
             :body, 
             :description, 
             :url, 
             :myspace_url, 
             :facebook_url, 
             :audio_sample_url, 
             :video_url, 
             :twitter, 
             :youtube1, 
             :youtube2, 
             :created_at, 
             :updated_at


node( :headlining) do |artist|
  event = Event.find_by_headliner_id(artist.id)
  events = []
  if event
    events.push( {:id => event.id, :title => event.title} )
  end
  events
end

node :photo_thumb do |a|
  a.photo.url(:thumb).gsub(/\+/, '%2B')
end

node :photo do |a|
  a.photo.url(:medium).gsub(/\+/, '%2B')
end
  


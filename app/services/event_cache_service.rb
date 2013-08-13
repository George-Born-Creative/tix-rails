class EventCacheService
  include RenderAnywhere
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  
  def initialize(event_id)
    @event = Event.find(event_id)
  end
  
  def perform
    cache @event
  end
  
  def cache(event)
    cache_provider.write( cache_key(event), render_to_string(event) )
    return cache_key(event)
  end
  
  def render_to_string(event)
    render(
        :partial => partial_path, 
        :locals => {:event => event},
        :only_path => true
    )
  end
  
  def cache_provider
    Rails.cache
  end
  
  def cache_key(event)
    event.cache_key + cache_signature
  end
  
  def cache_signature
    '_event_cache_job'
  end
  
  def partial_path
    ['front', 'events', 'event'].join('/')
  end
end
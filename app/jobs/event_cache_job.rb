require 'render_anywhere'

class EventCacheJob < Struct.new(:event_id)
  def perform
    cache_service = EventCacheService.new(event_id)
    cache_service.perform
  end
  
end
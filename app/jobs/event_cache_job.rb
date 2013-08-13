require 'render_anywhere'

class EventCacheJob < Struct.new(:event_id)
  REPEAT_EVERY = 2.minutes
  
  def perform
    cache_service = EventCacheService.new(event_id)
    cache_service.perform
    reschedule
  end
  
  def reschedule
    Delayed::Job.enqueue( EventCacheJob.new(event_id), run_at: REPEAT_EVERY.from_now)
  end
  
end
require 'render_anywhere'

class EventsCacheJob
  REPEAT_EVERY = ENV['EVENTS_CACHE_REPEAT_EVERY'].to_i.minutes
  
  def perform
    Event.current.each{ |event| Delayed::Job.enqueue( EventCacheJob.new( event.id ) ) }
    reschedule
  end
  
  def reschedule
    Delayed::Job.enqueue( EventsCacheJob.new, run_at: REPEAT_EVERY.from_now)
  end
  
end
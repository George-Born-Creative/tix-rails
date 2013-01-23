class EventSearchIndexService
  
  def self.index_all_events
    Event.find_each do |event|
      Delayed::Job.enqueue(EventSearchIndexJob.new(event.id))
    end
  end

  
end
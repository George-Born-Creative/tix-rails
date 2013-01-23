class EventSearchIndexJob < Struct.new(:event_id)
  def perform
    event = Event.find(event_id)
    if event.valid?
      event.cache_search_keywords
      event.save!
    end
  end
end
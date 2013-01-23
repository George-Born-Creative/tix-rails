class AddSearchKeywordsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :search_keywords, :text
    execute("create index index_events_on_search_keywords on events using gin(to_tsvector('simple', search_keywords))")
    
  end
  
end

class CreateEventsSupportingActs < ActiveRecord::Migration
  def change
    create_table :events_supporting_acts do |t|
      t.integer :event_id, :null => :false
      t.integer :artist_id, :null => :false
    end
  end
end

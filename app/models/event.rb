class Event < ActiveRecord::Base
  attr_accessible :ends_at, :headline, :body, :image_thumb_uri, :image_uri, :seating_chart_id, :starts_at, :supporting_act, :title
end

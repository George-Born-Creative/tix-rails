class SingleSeat < ActiveRecord::Base
  belongs_to :seating_chart
  attr_accessible :label, :x, :y
  
end

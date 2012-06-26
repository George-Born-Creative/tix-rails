class AreaSeat < ActiveRecord::Base
  belongs_to :seating_chart
  
  attr_accessible :polypath
end

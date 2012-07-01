class SingleSeat < ActiveRecord::Base
  belongs_to :seating_chart
  attr_accessible  :x, :y, :label, :default_price
  
end

class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :area
  
  attr_accessible :price, :state
  
  
end
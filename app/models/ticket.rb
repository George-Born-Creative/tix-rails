class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :area
  
  attr_accessible :price, :state
  
  attr_accessor :label, :area_label, :area_type
  
  def label
    "Seat #{self.id}"
  end
  
  def area_label
    self.area.label_section
  end
  
  def area_type
    self.area.type
  end
end
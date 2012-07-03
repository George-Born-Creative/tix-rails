class Area < ActiveRecord::Base
  attr_accessible :x, :y, :polypath, :label, :stack_order
  attr_accessor :poly
  
  belongs_to :chart
  
  def poly?
    !self.polypath.nil?
  end
  
  
    
    
end
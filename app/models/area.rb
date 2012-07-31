class Area < ActiveRecord::Base
  attr_accessible :x, :y, :polypath, :label, :label_section, :stack_order
  attr_accessor :type
  
  
  belongs_to :chart
  has_many :tickets
  
  # :single :area :invalid
  
  def type
    if ( self.polypath.nil? ) && ( ! self.x.nil? ) && (!self.y.nil?) 
      return :single
    elsif ( !self.polypath.nil? ) && ( self.x.nil? ) && ( self.y.nil?) 
      return :area
    else
      return :invalid
    end
  end
  
  
    
    
end
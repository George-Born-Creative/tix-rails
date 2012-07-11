class Event < ActiveRecord::Base
  attr_accessible :title, :headline, :supporting_act, :body, :image_uri, :image_thumb_uri, :starts_at, :ends_at
  attr_accessor :starts_at_formatted 
  
  belongs_to :chart
  has_many :tickets
  
  def starts_at_formatted
    self.created_at.to_formatted_s(:long_ordinal)
  end
end


    

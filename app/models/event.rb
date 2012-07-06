class Event < ActiveRecord::Base
  attr_accessible :title, :headline, :supporting_act, :body, :image_uri, :image_thumb_uri, :starts_at, :ends_at
  
  belongs_to :chart
  
  has_many :tickets
  
end


    

class CarouselItems < ActiveRecord::Base
  attr_accessible :title, :caption, :link, :image
  
  belongs_to :carousel
  has_one :image, :as => :imageable
  
end
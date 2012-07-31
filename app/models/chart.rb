class Chart < ActiveRecord::Base
  attr_accessible :name, :background_image_url
  
  belongs_to :account
  has_many :areas
  has_many :events
  
  
end


class SeatingChart < ActiveRecord::Base
  attr_accessible :background_image_url, :name
  has_many :single_seats
  has_many :area_seats
end

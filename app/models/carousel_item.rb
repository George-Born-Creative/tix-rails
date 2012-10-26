# == Schema Information
#
# Table name: carousel_items
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  caption    :string(255)
#  link       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CarouselItem < ActiveRecord::Base
  attr_accessible :title, :caption, :link, :image
  
  belongs_to :carousel
  has_one :image, :as => :imageable
  
end

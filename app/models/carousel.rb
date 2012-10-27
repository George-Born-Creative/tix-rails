# == Schema Information
#
# Table name: carousels
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Carousel < ActiveRecord::Base
  attr_accessible :slug 
  
  belongs_to :account
  has_many :carousel_items#, :class_name => 'CarouselItem'
  
  validates_uniqueness_of :slug, :scope => :account_id
  
  
  
end

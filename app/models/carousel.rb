class Carousel < ActiveRecord::Base
  attr_accessible :slug 
  
  belongs_to :account
  has_many :carousel_items
  
  validates_uniqueness_of :slug, :scope => :account_id
  
  
end
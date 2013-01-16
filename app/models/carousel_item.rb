# == Schema Information
#
# Table name: carousel_items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  caption     :string(255)
#  link        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  expires_at  :datetime
#  index       :integer
#  carousel_id :integer
#

class CarouselItem < ActiveRecord::Base
  attr_accessible :title, :caption, :link, :image, :expires_at, :index, :carousel, :image_attributes
  belongs_to :carousel, :touch => true
  
  delegate :account, :to => :carousel
  
  has_one :image, :as => :imageable
  
  before_save :touch_pages
  
  accepts_nested_attributes_for :image, :allow_destroy => true
  
  # def expired?
  #   Time.zone.now < self.expired_at 
  # end
  
  def touch_pages
    # TODO -- currently touches page with home slug only. 
    #         create a method to specify which pages should be re-cached
    # account.pages.each{|page| page.touch}
    account.pages.find_by_slug('home').touch
  end
  
end


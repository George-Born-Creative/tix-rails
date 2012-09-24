class Widget < ActiveRecord::Base
  
  has_many :widget_placements
  has_many :sidebars, :through => :widget_placeements
  belongs_to :account
  
  attr_accessible :body, :slug, :title, :account_id
  
  validates_uniqueness_of :slug, :scope => :account_id
end

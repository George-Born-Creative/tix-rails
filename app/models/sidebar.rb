class Sidebar < ActiveRecord::Base
  attr_accessible :slug, :title
  
  has_many :widget_placements
  has_many :widgets, :through => :widget_placements
  
  has_many :pages
  
  belongs_to :account
  validates_uniqueness_of :slug, :scope => :account_id
  
  
end

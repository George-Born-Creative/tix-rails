class Account < ActiveRecord::Base
  has_many :users
  has_many :artists
  has_many :charts
  has_many :events
  has_many :tickets
  has_many :orders
  
  attr_accessible :subdomain
  
  validates_uniqueness_of :subdomain
end

# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  subdomain  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :artists, :dependent => :destroy
  has_many :charts, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :tickets, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  has_many :charts, :dependent => :destroy
  
  has_many :ticket_templates, :dependent => :destroy
  has_many :customer_imports, :dependent => :destroy
  
  attr_accessible :subdomain
  
  validates_uniqueness_of :subdomain
  
  def random(model_name) # as sym
      
    case model_name
      
    when :event
      r = rand(self.events.count)
      m = self.events.offset(r).first
    when :artist
      r = rand(self.artists.count)
      m = self.artists.offset(r).first
    end
    
    m
    
  end
end

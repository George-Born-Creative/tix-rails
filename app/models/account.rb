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
  has_many :sidebars, :dependent => :destroy  
  has_many :images, :dependent => :destroy  
  has_many :widgets, :dependent => :destroy
  has_many :ticket_templates, :dependent => :destroy
  has_many :customer_imports, :dependent => :destroy
  
  attr_accessible :subdomain
  
  validates_uniqueness_of :subdomain
  
  def random(model_name) # as sym
      
    if self.send(model_name) && self.send(model_name).count > 0  
      r = rand(self.send(model_name).count)
      m = self.send(model_name).offset(r).first
    else
      return nil
    end
    
    
  end
end

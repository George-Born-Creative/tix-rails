# == Schema Information
#
# Table name: accounts
#
#  id                      :integer          not null, primary key
#  subdomain               :string(255)      not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  email_order_report_to   :string(255)
#  email_daily_report_to   :string(255)
#  email_weekly_report_to  :string(255)
#  email_monthly_report_to :string(255)
#

class Account < ActiveRecord::Base
  has_many :domains, :class_name => 'AccountDomain', :inverse_of => :account, :dependent => :destroy
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
  has_many :carousels, :dependent => :destroy
  has_many :themes, :dependent => :destroy
  has_many :gateways, :dependent => :destroy
    
  attr_accessible :subdomain, 
          :email_order_report_to, :email_daily_report_to, :email_weekly_report_to,
          :email_monthly_report_to
  
  
  validates_uniqueness_of :subdomain
  
  def random(model_name) # as sym
      
    if self.send(model_name) && self.send(model_name).count > 0  
      r = rand(self.send(model_name).count)
      m = self.send(model_name).offset(r).first
    else
      return nil
    end
    
    
  end
  
  def root_url(prod=true) # [PROD=true, DEV=f]
    if prod
      "https://#{subdomain}.thintix.com/"
    else
      "http://#{subdomain}.localtix.com:5000/"
    end
  end
  
  def gateway
    return nil if gateways.nil?
    gateways.active
  end
  
  def authorize_gateway
    return nil? if gateway.blank? || gateway.login.blank? || gateway.password.blank?
    @authorize_gateway ||= ActiveMerchant::Billing::AuthorizeNetGateway.new(
        :login => gateway.login,
        :password => gateway.password
    )
  end
end

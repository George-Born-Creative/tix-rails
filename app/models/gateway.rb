# == Schema Information
#
# Table name: gateways
#
#  id           :integer          not null, primary key
#  provider     :string(255)
#  login        :string(255)
#  password     :string(255)
#  activated_at :datetime
#  account_id   :integer
#  mode         :string(255)
#

class Gateway < ActiveRecord::Base
  belongs_to :account
  attr_accessible :provider, :login, :password, :pass,
    :account, :mode, :activated_at
  
  # PROVIDERS = [:authorize]
  MODES = ['test', 'live']
  
  # validates :provider, :inclusion => {:in => Gateway::PROVIDERS}
  validates :mode, :inclusion => {:in => Gateway::MODES}
  validates :login, :pass, :presence => true
  
  
  scope :active_gateways, where("activated_at is NOT NULL").order('activated_at DESC')

  alias_attribute :pass, :password
  
  def activate!
    update_attribute(:activated_at, Time.zone.now)
  end

  class << 
    def self.active # Account.gateways.active
      return nil if self.active_gateways.blank?
      self.active_gateways.first
    end
  end
  
  def authorize_net
     return nil? if blank? || login.blank? || password.blank?
     
     if test_mode?
       ActiveMerchant::Billing::Base.mode = :test
       return ActiveMerchant::Billing::AuthorizeNetGateway.new(
           :login => login, :password => password, :test => true )
     else
       ActiveMerchant::Billing::Base.mode = :production
       return ActiveMerchant::Billing::AuthorizeNetGateway.new(
            :login => login, :password => password )
     end
       
   end
   
   def test_mode?
     self.mode == 'test'
   end
  
end

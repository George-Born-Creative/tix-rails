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
  
  PROVIDERS = [:authorize]
  MODES = [:test, :live]
  
  validate :provider, :inclusion => {:in => PROVIDERS}
  validate :mode, :inclusion => {:in => MODES}
  
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
     @authorize_gateway ||= ActiveMerchant::Billing::AuthorizeNetGateway.new(
         :login => login,
         :password => password
     )
   end
  
end

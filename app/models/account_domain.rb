# == Schema Information
#
# Table name: account_domains
#
#  id         :integer          not null, primary key
#  domain     :string(255)      not null
#  account_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AccountDomain < ActiveRecord::Base
  attr_accessible :domain, :account
  
  belongs_to :account, :inverse_of => :domains
  
  validates_uniqueness_of :domain # global: unique across all thintix sites
  
end

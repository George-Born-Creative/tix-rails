# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  subdomain  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Account do

  it "should not create doubles" do
    Account.delete_all
    account = Account.create(:subdomain => 'squiid')
    Account.create(:subdomain => 'squiid').should_not be_valid
   
  end
  
  
end

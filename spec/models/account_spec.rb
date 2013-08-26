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

require 'spec_helper'

describe Account do

  before :each do
    Account.delete_all
  end
  
  it 'has a valid factory' do
    FactoryGirl.build_stubbed(:account).should be_valid
  end
  
  it 'is invalid without a subdomain' do
    FactoryGirl.build_stubbed(:account, subdomain: nil).should_not be_valid 
  end
  
  it 'is invalid if it has a duplicate subdomain' do
    FactoryGirl.create(:account)
    FactoryGirl.build(:account).should_not be_valid
  end
  
end

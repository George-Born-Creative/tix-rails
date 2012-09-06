# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :integer          default(0), not null
#  first_name             :string(255)
#  middle_name            :string(255)
#  last_name              :string(255)
#  salutation             :string(255)
#  title                  :string(255)
#  role                   :string(255)      default("customer")
#  balance                :decimal(8, 2)    default(0.0), not null
#

require 'spec_helper'

describe User do
  
  before :each do
    @user = User.new
  end
    
  it "should have a starting balance of 0.00" do
    @user.balance.should eq 0.00
  end
  
  it "should accept negative balances" do
    @user.balance = -10.00
    @user.balance.should eq -10.00
  end
  
  it "should accept positive balances" do
    @user.balance = 10.00
    @user.balance.should eq 10.00
  end
  
  
end

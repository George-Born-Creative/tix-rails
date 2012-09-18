# == Schema Information
#
# Table name: sections
#
#  id                     :integer          not null, primary key
#  label                  :string(255)
#  default_base_price     :decimal(8, 2)    default(0.0), not null
#  default_service_charge :decimal(8, 2)    default(0.0), not null
#  chart_id               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  seatable               :boolean          default(FALSE), not null
#  color                  :string(255)
#

require 'spec_helper'

describe Section do

  it "should create" do
    @account = mock_model("Account", :subdomain => 'squiid')
    @chart = mock_model("Chart", :name => 'Seated Room', :account_id => @account.id)
    @section = Section.create({
      :chart_id => @chart.id,
      :label => 'VIP',
      :default_base_price => 10.00,
      :default_service_charge => 3.00
    })
  end
  
  
end

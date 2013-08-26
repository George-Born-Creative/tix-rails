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
#  dayof_price_id         :integer
#  presale_price_id       :integer
#  index                  :integer
#

require 'spec_helper'

describe Section do

  pending "should create" do
    
  end
  
  
end

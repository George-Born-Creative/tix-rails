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
#

class Section < ActiveRecord::Base
  belongs_to :chart
  belongs_to :account
  
  has_many :areas
  
  attr_accessible :chart_id, :label, :default_base_price, :default_service_charge, :seatable
  
  
end

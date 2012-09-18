# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  label      :string(255)
#  base       :decimal(8, 2)    default(0.0), not null
#  service    :decimal(8, 2)    default(0.0), not null
#  tax        :decimal(8, 2)    default(0.0), not null
#  account_id :integer
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Price < ActiveRecord::Base
  
  attr_accessible  :account, :base, :service, :tax, :account_id
  
  has_one :section
  
  def total
    self.base + self.service + self.tax
  end
  
  def to_s
    #{}"#{self.label}: total #{self.total} = base: #{self.base} + service: #{self.service} + tax: #{self.tax}"    
    "$#{"%.2f" % self.base} + $#{"%.2f" % self.service} = $#{"%.2f" % self.total}"
  end
end

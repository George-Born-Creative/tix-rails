# == Schema Information
#
# Table name: order_transactions
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  action        :string(255)
#  amount        :integer
#  success       :boolean
#  authorization :string(255)
#  message       :string(255)
#  params        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  meth          :string(255)
#  origin        :string(255)
#

class OrderTransaction < ActiveRecord::Base
  belongs_to :order
  serialize :params
  
  attr_accessible :action, :amount, :response, :meth, :origin, :success
  
  METH = [:cash, :card, :square, :check, :pos, :other]
  ORIGINS = [:web, :agent, :kiosk]
  
  # validates :meth, :inclusion => {:in => METH}
  # validates :origin, :inclusion => {:in => ORIGINS}
  
  scope :success, lambda { where("success = ?", true)}
  scope :fail, lambda { where("success = ?", false)}
  
  def response=(response)
    self.success       = response.success?
    self.authorization = response.authorization
    self.message       = response.message
    self.params        = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success       = false
    self.authorization = nil
    self.message       = e.message
    self.params        = {}
  end
  
  def total
    (amount / 1000).to_f
  end
  
 
end

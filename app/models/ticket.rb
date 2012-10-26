# == Schema Information
#
# Table name: tickets
#
#  id             :integer          not null, primary key
#  price          :decimal(, )
#  state          :string(255)      not null
#  event_id       :integer
#  area_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  order_id       :integer
#  account_id     :integer          default(0), not null
#  base_price     :decimal(, )
#  service_charge :decimal(, )
#  area_label     :string(255)
#  section_label  :string(255)
#  checked_in_at  :datetime
#  status         :string(255)
#

# Ticket
# Connects an Order to a Set
# Has three states: reserved, purchased, checked in

# Reserved: a ticket has been added to a cart 
# Purchased: The ticket has been purchased but not yet checked in
# Checked_in: The ticket has been scanned in

class Ticket < ActiveRecord::Base
  attr_accessible :area, :order, :state
  
  before_save :set_info
  # before_create :set_initial_state
  
  
  attr_accessor :reserved, :purchased, :checked_in
  
  belongs_to :order
  belongs_to :area
  delegate :section, :to => :area
  
  validates_presence_of :area
  validates_presence_of :order
    
  scope :expired, lambda { self.joins(:order).where('orders.expires_at <= ?', Time.zone.now) }  
  scope :cart, lambda { self.joins(:order).where('orders.expires_at > ?', Time.zone.now) }
  

  state_machine :state, :initial => :reserved do
    state :reserved
    state :purchased
    state :checked_in
  end
    
  
  def total_price
    self.base_price + self.service_charge
  end  
  
  def event
    self.area.section.chart.event
  end
  
  # Ticket.order 
  
  # Order.expired
  
  
  private 
  def set_info
    self.area_label = self.area.label
    self.section_label = self.area.section.label
    self.base_price = self.area.section.current_price.base
    self.service_charge = self.area.section.current_price.service
  end
  
  
  # def set_initial_state
  #   self.state = 'cart' if self.state.blank?
  # end
  
  
    
end

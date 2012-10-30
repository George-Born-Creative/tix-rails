# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  price           :decimal(, )
#  state           :string(255)      not null
#  event_id        :integer
#  area_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :integer
#  account_id      :integer          default(0), not null
#  base_price      :decimal(, )
#  service_charge  :decimal(, )
#  area_label      :string(255)
#  section_label   :string(255)
#  checked_in_at   :datetime
#  status          :string(255)
#  event_name      :string(255)
#  event_starts_at :datetime
#

# Ticket
# Connects an Order to a Set
# Has three states: reserved, purchased, checked in

# Reserved: a ticket has been added to a cart 
# Purchased: The ticket has been purchased but not yet checked in
# Checked_in: The ticket has been scanned in

class Ticket < ActiveRecord::Base
  attr_accessible :area, :order, :state, :event_name, 
                  :area_label, :section_label, :base_price,
                  :service_charge
  
  before_save :set_info
  before_create :set_info
  
  # before_create :set_initial_state
  
  
  attr_accessor :reserved, :purchased, :checked_in
  
  belongs_to :order
  belongs_to :area
  delegate :section, :to => :area
  delegate :full_name, :to => :order
  validates_presence_of :area
  validates_presence_of :order
    
  scope :expired, lambda { joins(:order).where('orders.expires_at <= ?', Time.zone.now) }  
  scope :cart, lambda { joins(:order).where('orders.expires_at > ?', Time.zone.now) }
  

  state_machine :state, :initial => :reserved do
    state :reserved
    state :purchased
    state :checked_in
  end
    
  
  def total_price
    base_price + service_charge
  end  
  
  def event
    area.section.chart.event
  end
  
  # Ticket.order 
  # Order.expired
  
  def total
    self.base_price + self.service_charge
  end
    
  
  private 
  
  def set_info # ®
    puts "Setinfo: #{event.name}"
    self.area_label = area.label
    self.event_name = event.name
    self.event_artists = event.artists_str
    self.event_starts_at = area.section.chart.event.starts_at
    self.section_label = area.section.label
    self.base_price = area.section.current_price.base
    self.service_charge = area.section.current_price.service
  end
  
  
  # def set_initial_state
  #   state = 'cart' if state.blank?
  # end
  
  
    
end

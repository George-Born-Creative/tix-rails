# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  price           :decimal(, )
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
#  event_artists   :string(255)
#

# Ticket
# Connects an Order to a Set
# Has three states: reserved, purchased, checked in

# Reserved: a ticket has been added to a cart 
# Purchased: The ticket has been purchased but not yet checked in
# Checked_in: The ticket has been scanned in

class Ticket < ActiveRecord::Base
  attr_accessible :area, :order, :event_name, 
                  :area_label, :section_label, :base_price,
                  :service_charge, :event_artists, :event_starts_at
  
  before_save :set_info
  before_create :set_info
  
  # before_create :set_initial_state

  attr_accessor :reserved, :purchased, :checked_in
  
  belongs_to :order
  belongs_to :area
  delegate :section, :to => :area
  delegate :full_name, :to => :order
  delegate :state, :to => :order
  
  validates_presence_of :area
  validates_presence_of :order
    
  scope :expired, lambda { joins(:order).where('orders.expires_at <= ? AND purchased_at IS ?', Time.zone.now, nil) }  
  scope :cart, lambda { joins(:order).where('orders.expires_at > ? AND purchased_at IS ?', Time.zone.now, nil) }
  scope :complete, lambda { joins(:order).where("orders.purchased_at < ?", Time.zone.now)}
  
  
  
  def event
    area.section.chart.event
  end
  
  # Ticket.order 
  # Order.expired
  
  def total
    base = self.base_price || 0
    service = self.service_charge || 0
    base + service
  end
    
  
  private 
  
  def set_info
    puts "setting self.event_name = event.name"
    self.event_name = event.name
    puts self.event_name
    
    puts "setting self.event_artists = event.artists_str"
    self.event_artists = event.artists_str
    self.event_artists
    
    
    puts "setting self.event_starts_at = area.section.chart.event.starts_at"
    self.event_starts_at = area.section.chart.event.starts_at
    puts self.event_starts_at
    
    puts "setting self.section_label = area.section.label"
    self.section_label = area.section.label
    puts self.section_label
    
    puts "setting self.area_label = area.labelname"
    self.area_label = area.label
    puts self.area_label
    
    puts "self.base_price = area.section.current_price."
    self.base_price = area.section.current_price.base
    puts self.base_price
    
    puts "self.service_charge = area.section.current_price.service"
    self.service_charge = area.section.current_price.service
    puts self.service_charge
    
    puts "SERVICE CHARGE IS #{self.service_charge}"
    puts "AREA LABEL IS #{self.area_label}"
    
    
  end
  
  
  
  
  
    
end

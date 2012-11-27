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
#  account_id      :integer          not null
#  base_price      :decimal(, )
#  service_charge  :decimal(, )
#  area_label      :string(255)
#  section_label   :string(255)
#  checked_in_at   :datetime
#  status          :string(255)
#  event_name      :string(255)
#  event_starts_at :datetime
#  event_artists   :string(255)
#  event_name_1    :string(255)
#  event_name_2    :string(255)
#

# Ticket
# Connects an Order to a Set
# Has three states: reserved, purchased, checked in

# Reserved: a ticket has been added to a cart 
# Purchased: The ticket has been purchased but not yet checked in
# Checked_in: The ticket has been scanned in

class Ticket < ActiveRecord::Base
  attr_accessible :area, :order, :event_name,  :event_id,
                  :area_label, :section_label, :base_price,
                  :service_charge, :event_artists, :event_starts_at
                  :service_charge, :event_artists, :event_starts_at,
                  :event_name_1, :event_name_1
  
  before_save :set_attributes
  belongs_to :account
  belongs_to :order
  
  # before_create :set_info
  
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
  scope :purchased_between, lambda { |start_time, end_time| joins(:order).where('orders.purchased_at BETWEEN ? AND ?', start_time, end_time) }
  scope :checked_in, lambda { joins(:order).where("checked_in_at < ?", Time.zone.now)}
  


  # scope :purchased_between, lambda { |start_time, end_time| where(:purchased_at => (start_time...end_time) }
  
  # Ticket.purchased_between(yesterday.beginning_of_day, yesterday.end_of_day).sum(:base_price, :group => :event_name).each {|a,b| puts "#{a} #{b}"}
  
  def self.for_event(event_id)
    where(:event_id => event_id)
  end
  
  def self.purchased_today
    today = Time.zone.now
    purchased_between(today.beginning_of_day, today.end_of_day)
  end
  
  def self.purchased_yesterday
    yesterday = Time.zone.now - 1.day
    purchased_between(yesterday.beginning_of_day, yesterday.end_of_day)
  end
  
  def self.purchased_this_week
    start_time = (Time.zone.now - 1.week).beginning_of_day
    end_time = Time.zone.now
    purchased_between(start_time, end_time)
  end
  
  
  def checkin!
    unless checked_in_at.nil?
      return false
    else
      update_attribute(:checked_in_at, Time.zone.now)
      return true
    end
  end
  
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
    
    
  def checked_in?
    !checked_in_at.nil?
  end
  
  def can_check_in?
    !checked_in?
  end
    
  def set_info
    puts "setting self.event_name = event.name"
    self.event_name = event.name
    puts self.event_name
    
    puts "setting self.event_artists = event.artists_str"
    self.event_artists = event.artists_str
    puts self.event_artists
    
    puts "setting self.event_starts_at = area.section.chart.event.starts_at"
    self.event_starts_at = area.section.chart.event.starts_at
    puts self.event_starts_at
    
    puts "setting self.section_label = area.section.label"
    self.section_label = area.section.label
    puts self.section_label
    
    puts "setting self.area_label = self.area.label"
    self.area_label = "#{self.area.label}"
    puts "self.area.label"
    puts self.area.label
    puts "self.area_label"
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
  
  
  private 
  
  def set_attributes
    self.account = self.order.account
    self.event_name = event.title_with_artists
    self.event_name_1 = event.title_array[0]
    self.event_name_2 = event.title_array[1]
    self.event_id = event.id
    self.event_artists = event.artists_str
    self.event_starts_at = area.section.chart.event.starts_at
    self.section_label = area.section.label
    self.area_label = area.label
    self.base_price = area.section.current_price.base
    self.service_charge = area.section.current_price.service
  end
  
  def self.total
    self.total_service + self.total_base
  end
  
  
  def self.total_service
    sum(:service_charge) # TODO ADD TAX?
  end
  
  
  def self.total_base
    sum(:base_price) # TODO ADD TAX?
  end
  
  
  
  
    
end

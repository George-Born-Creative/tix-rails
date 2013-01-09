# == Schema Information
#
# Table name: tickets
#
#  id                      :integer          not null, primary key
#  price                   :decimal(, )
#  event_id                :integer
#  area_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  order_id                :integer
#  account_id              :integer          not null
#  base_price              :decimal(, )
#  service_charge          :decimal(, )
#  area_label              :string(255)
#  section_label           :string(255)
#  checked_in_at           :datetime
#  status                  :string(255)
#  event_name              :string(255)
#  event_starts_at         :datetime
#  event_artists           :string(255)
#  event_name_1            :string(255)
#  event_name_2            :string(255)
#  service_charge_override :decimal(, )
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
                  :service_charge, :event_artists, :event_starts_at,
                  :event_name_1, :event_name_2
  
  before_save :update_service_charge  
  before_create :set_attributes
  
  belongs_to :account
  belongs_to :order, :inverse_of => :tickets
  belongs_to :event
  
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
  scope :checked_in, lambda { where("checked_in_at < ?", Time.zone.now) }
  scope :pending_checkin, lambda { joins(:order).where("checked_in_at IS NULL")}
  


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
      self.update_attribute(:checked_in_at, Time.zone.now)
      return true
    end
  end
  
  def event
    area.section.chart.event
  end
  
  # Ticket.order 
  # Order.expired
  
  def total
    # base = self.base_price || 0
    # service = self.service_charge || 0
    self.base_price + self.service_charge
  end
    
    
  def checked_in?
    !checked_in_at.nil?
  end
  
  def can_check_in?
    !checked_in?
  end
    
  
  # if the area label is a combo of letters and numbers, 
  # provide them in a couplet array. otherwise rtn false
  # i.e. ticket.table_seat[0] if ticket.table_seat
  #      ticket.table_seat[1] if ticket.table_seat
  
  def table_seat 
    return false if self.area_label.blank?
    match = /^([A-Za-z]+)([0-9]+)/.match(self.area_label)
    return false if match.nil?
    return [match[1], match[2]] if match.size == 3
    return false
  end
  
  def update!
    set_attributes
  end  
  
  private
  
  def set_attributes
    # puts 'Tickets#set_attribtues invoked'
    # puts "self.order.service_charge_override = #{self.order.service_charge_override}"    
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
  
  end
  
  
  def update_service_charge
   if self.service_charge_override.nil?
      self.service_charge = area.section.current_price.service
    else
      self.service_charge = self.service_charge_override
    end
  end
  
  def self.total
    self.total_service + self.total_base # TODO ADD TAX?
  end
  
  def self.total_service
    sum(:service_charge)
  end
  
  def self.total_base
    sum(:base_price)
  end
  
end

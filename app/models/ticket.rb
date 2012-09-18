# == Schema Information
#
# Table name: tickets
#
#  id             :integer          not null, primary key
#  price          :decimal(, )
#  state          :string(255)      default("open"), not null
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
#

class Ticket < ActiveRecord::Base
  
  TICKET_TIME_OUT = 5.minutes
  
  belongs_to :event
  belongs_to :area
  belongs_to :order
  attr_accessor :status
  attr_accessor :price
  attr_accessible :event,
                  :area,
                  :area_id,
                  :seat_name,
                  :section_name,
                  :base_price,
                  :service_charge,
                  :status,
                  :area_label,
                  :section_label
  
  
  validates_presence_of :event
  validates_presence_of :order
  validates_presence_of :area
  
  alias_attribute :total, :total_price

  before_save :save_price
  
  def save_price
    self.price = self.area.section.current_price
    return false if @price.nil?
    self.base_price = @price.base
    self.service_charge = @price.service
  end
  
  def total_price
    self.base_price + self.service_charge
  end
  

  
end
